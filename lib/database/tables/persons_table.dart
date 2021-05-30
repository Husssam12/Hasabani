import 'package:moor_flutter/moor_flutter.dart';

class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get imageID => integer().withDefault(Constant(0))();
  RealColumn get deserved => real().withDefault(Constant(0.0))();
}
