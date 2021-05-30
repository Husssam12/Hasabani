import 'package:moor_flutter/moor_flutter.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get label => text()();
  IntColumn get price => integer()();
  IntColumn get personId =>
      integer().customConstraint('REFERENCES persons(id)')();
  DateTimeColumn get date => dateTime()();
}
