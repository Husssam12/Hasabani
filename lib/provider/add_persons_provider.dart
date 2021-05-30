import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app5/database/app_database.dart';
import 'package:flutter_app5/database/daos/_export_daos.dart';
import 'package:moor_flutter/moor_flutter.dart';

class AddPersonsProvider extends ChangeNotifier {
  final PersonsDao _personsDao;
  late String _name;
  late int _imageId;
  late bool _enableAddButton;
  late final int? _peronId;
  late final bool isEdit;

  AddPersonsProvider(this._personsDao, BuildContext context) {
    final data = context.currentBeamLocation.state.data;
    this._imageId = data['imageId'];
    this._name = data['name'];
    this._peronId = data['personId'];
    this._enableAddButton = false;
    isEdit = _peronId != null;
  }

  String get name => _name;

  int get imageId => _imageId;

  bool get enableAddButton => _enableAddButton;

  set imageId(int value) {
    _imageId = value;
    notifyListeners();
    _validate();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set enableAddButton(bool value) {
    _enableAddButton = value;
    notifyListeners();
  }

  onNameChange(String? value) {
    name = value!;
    _validate();
  }

  addOrUpdatePerson() {
    if (!isEdit) {
      _personsDao.insert(PersonsCompanion(
        name: Value(_name),
        imageID: Value(imageId),
      ));
    } else {
      _personsDao.updatePerson(
          PersonsCompanion(
            name: Value(_name),
            imageID: Value(imageId),
          ),
          _peronId!);
    }
  }

  _validate() {
    if (name.trim().isNotEmpty) {
      if (!_enableAddButton) enableAddButton = true;
    } else if (_enableAddButton) enableAddButton = false;
  }
}
