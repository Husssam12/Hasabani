import 'package:flutter_app5/database/tables/export_tables.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'daos/_export_daos.dart';

part 'app_database.g.dart';

@UseMoor(tables: [
  Persons,
  Items,
  ItemsDetails
], daos: [
  PersonsDao,
  ItemsDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.shared_box', logStatements: true));

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  @override
  int get schemaVersion => 1;
}
