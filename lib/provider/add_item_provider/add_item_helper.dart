import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/database/daos/_export_daos.dart';
import 'package:flutter_app5/models/add_item_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

class AddItemHelper {
  final AppDatabase _appDatabase;
  late final PersonsDao personsDao;
  late final ItemsDao itemsDao;
  AddItemHelper(this._appDatabase) {
    personsDao = _appDatabase.personsDao;
    itemsDao = _appDatabase.itemsDao;
  }

  Future<List<Person>> loadPerson() {
    return _appDatabase.personsDao.getAll();
  }

  Future<void> addItem({
    required AddItemModel addItemModel,
    DateTime? dateTime,
  }) async {
    final int price = int.parse(addItemModel.price);
    final int _bayerId = addItemModel.bayer!.id;
    final label = addItemModel.label;
    final bayer = await personsDao.getById(addItemModel.bayer!.id);
    final partners = await personsDao
        .getByIds(addItemModel.partners.map((e) => e.id).toList());
    int partnersCount = partners.length;

    ///______________________________________________///

    Item lastItem = await (itemsDao.insertItem(ItemsCompanion(
      label: Value(label),
      date: Value(dateTime ?? DateTime.now()),
      price: Value(price),
      personId: Value(_bayerId),
    )));

    ///set partners in items details table///
    for (int index = 0; index < partnersCount; index++) {
      await itemsDao.insertItemsDetails(ItemsDetailsCompanion(
          personId: Value(partners[index].id), itemId: Value(lastItem.id)));
    }

    await _updateDeserved(
        state: 1, bayer: bayer, partners: partners, price: price);
  }

  updateItem({
    required int itemId,
    required AddItemModel addItemModel,
  }) async {
    final deletedItem = await deleteItem(itemId: itemId);
    addItem(addItemModel: addItemModel, dateTime: deletedItem.date);
  }

  Future<Item> deleteItem({
    required int itemId,
  }) async {
    final AddItemModel oldAddItemModel = await getAddItemModel(itemId);
    final int price = int.parse(oldAddItemModel.price);
    final bayer = oldAddItemModel.bayer!;
    final partners = oldAddItemModel.partners;
    await _updateDeserved(
        state: -1, bayer: bayer, partners: partners, price: price);
    return itemsDao.deleteItem(itemId);
  }

  _updateDeserved(
      {required int state,
      required Person bayer,
      required List<Person> partners,
      required int price}) async {
    final int partnersCount = partners.length;
    final int bayerId = bayer.id;

    /// calculate deserved for every partner///
    int deserved = price ~/ partnersCount;
    int rest = price % partnersCount;
    final bool _bayerIsPartner =
        partners.singleWhereOrNull((element) => element.id == bayerId) != null;

    ///update bayer Deserved///
    if (_bayerIsPartner) {
      bayer = bayer.copyWith(
        deserved: bayer.deserved + ((deserved * (partnersCount - 1)) * state),
      );
      await personsDao.updatePerson(bayer, bayerId);
      partners.removeWhere((element) => element.id == bayerId);
    } else {
      bayer = bayer.copyWith(deserved: bayer.deserved + (price) * state);
      await personsDao.updatePerson(bayer, bayerId);
    }

    ///update partners Deserved///
    for (int i = 0; i < partners.length; i++) {
      partners[i] = partners[i]
          .copyWith(deserved: partners[i].deserved - (state * (deserved)));
      await personsDao.updatePerson(partners[i], partners[i].id);
    }

    if (rest > 0) {
      await personsDao.updatePerson(
          bayer.copyWith(deserved: bayer.deserved + (rest * state)), bayer.id);
      for (int i = 1, j = 0; i <= rest; i++, j++) {
        await personsDao.updatePerson(
            partners[j].copyWith(deserved: partners[j].deserved - (state * 1)),
            partners[j].id);
      }
    }
  }

  Future<AddItemModel> getAddItemModel(int itemId) async {
    final partners = await _appDatabase.itemsDao.getPartners(itemId);
    final bayer = await _appDatabase.itemsDao.getBayer(itemId);
    final item = await _appDatabase.itemsDao.getItemById(itemId);
    return AddItemModel(
        partners: partners,
        price: item.price.toString(),
        label: item.label,
        bayer: bayer);
  }
}
