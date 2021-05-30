import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/models/add_item_model.dart';

import 'add_item_helper.dart';

class AddItemProvider extends ChangeNotifier {
  late List<Person> _persons = [];

  ///form validation
  final GlobalKey<FormState> formKey;
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  /// for add item
  final AddItemHelper _addItemHelper;
  AddItemModel? addItemModel;

  /// edit or add
  late final int? itemId;
  late bool isEdit;

  AddItemProvider(this._addItemHelper, this.formKey, BuildContext context) {
    final data = context.currentBeamLocation.state.data;
    _init(data);
  }

  _init(data) async {
    this.itemId = data['item_id'];
    isEdit = itemId != null;
    if (!isEdit) {
      addItemModel =
          AddItemModel(partners: [], price: '', label: '', bayer: null);
    } else {
      addItemModel = await _addItemHelper.getAddItemModel(itemId!);
    }
    _loadPersons();
  }

  AutovalidateMode get validateMode => _validateMode;

  List<Person> get persons => _persons;

  set validateMode(AutovalidateMode value) {
    _validateMode = value;
    notifyListeners();
  }

  set persons(List<Person> value) {
    _persons = value;
    notifyListeners();
  }

  onPriceChange(String? value) {
    addItemModel = addItemModel!.copyWith(price: value);
  }

  onLabelChange(String? value) {
    addItemModel = addItemModel!.copyWith(label: value);
  }

  void onPartnersChange(List<Person> value) {
    addItemModel = addItemModel!.copyWith(partners: value);
  }

  onBayerChange(Person? value) {
    addItemModel = addItemModel!.copyWith(bayer: value);
  }

  Future<void> _loadPersons() async {
    persons = await _addItemHelper.loadPerson();
  }

  Future<void> addItem() async {
    if (formKey.currentState!.validate()) {
      if (!isEdit) {
        validateMode = AutovalidateMode.disabled;
        await _addItem();
        await _loadPersons();
        _reset();
      } else {
        await _addItemHelper.updateItem(
            itemId: itemId!, addItemModel: addItemModel!);
      }
    } else {
      validateMode = AutovalidateMode.onUserInteraction;
    }
  }

  Future<void> deleteItem() async {
    await _addItemHelper.deleteItem(itemId: itemId!);
  }

  Future<void> _addItem() async {
    await _addItemHelper.addItem(addItemModel: addItemModel!);
  }

  void _reset() {
    addItemModel =
        AddItemModel(partners: [], price: '', label: '', bayer: null);
    formKey.currentState?.reset();
  }
}
