import 'package:flutter_app5/database/tables/export_tables.dart';
import 'package:flutter_app5/models/item_bayer_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

part 'items_dao.g.dart';

@UseDao(tables: [Items, ItemsDetails, Persons])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  final AppDatabase db;
  ItemsDao(this.db) : super(db);

  Future<List<Item>> getAllItems() => select(items).get();
  Future<Item> getItemById(int itemId) =>
      (select(items)..where((tbl) => tbl.id.equals(itemId))).getSingle();
  Future deleteAllItems() => delete(items).go();
  Future<List<Item>> getItemsForPerson(int id) =>
      (select(items)..where((tbl) => tbl.personId.equals(id))).get();
  Stream<List<Item>> watchAllItems() => (select(items)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
      .watch();
  Future<Item> insertItem(Insertable<Item> item) => into(items)
      .insert(item)
      .then((_) => select(items).get().then((value) => value.last));
  Future updateItem(Insertable<Item> item) => update(items).replace(item);
  Future insertItemsDetails(Insertable<ItemsDetail> itemsDetail) =>
      into(itemsDetails).insert(itemsDetail);
  Future<Item> deleteItem(int itemId) async {
    final deletedItem = await getItemById(itemId);
    await (delete(items)..where((tbl) => tbl.id.equals(itemId))).go();
    return deletedItem;
  }

  Future<List<Person>> getPartners(int itemId) {
    final query = select(persons).join([
      innerJoin(
          itemsDetails,
          itemsDetails.personId.equalsExp(persons.id) &
              itemsDetails.itemId.equals(itemId),
          useColumns: false),
      innerJoin(items, itemsDetails.itemId.equalsExp(items.id))
    ]);
    return query.map((row) => row.readTable(persons)).get();
  }

  Future<Person> getBayer(int itemId) {
    final query = select(persons).join([
      innerJoin(
          items, items.personId.equalsExp(persons.id) & items.id.equals(itemId))
    ]);
    return query.map((row) => row.readTable(persons)).getSingle();
  }

  Stream<List<ItemBayerModel>> watchAllItemsWithBayer() {
    final query = select(items).join([
      innerJoin(persons, persons.id.equalsExp(items.personId)),
    ]);
    return query.map((row) {
      final item = ItemBayerModel(
          item: row.readTable(items), person: row.readTable(persons));
      return item;
    }).watch();
  }
}
