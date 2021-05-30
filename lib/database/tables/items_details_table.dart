import 'package:moor_flutter/moor_flutter.dart';

class ItemsDetails extends Table {
  IntColumn get personId =>
      integer().customConstraint('REFERENCES persons(id)')();
  IntColumn get itemId =>
      integer().customConstraint('REFERENCES items(id) ON DELETE CASCADE')();
}
