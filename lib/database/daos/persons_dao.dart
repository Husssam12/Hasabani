import 'package:flutter_app5/database/tables/export_tables.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

part 'persons_dao.g.dart';

@UseDao(tables: [Persons, Items, ItemsDetails])
class PersonsDao extends DatabaseAccessor<AppDatabase> with _$PersonsDaoMixin {
  final AppDatabase db;
  PersonsDao(this.db) : super(db);

  Future<List<Person>> getAll() => select(persons).get();

  Stream<List<Person>> watchAll() => select(persons).watch();
  Future insert(Insertable<Person> person) => into(persons).insert(person);
  Future updatePerson(Insertable<Person> person, int personId) =>
      (update(persons).replace(person));
  Future<Person> getById(int id) =>
      (select(persons)..where((tbl) => tbl.id.equals(id))).getSingle();
  Future<List<Person>> getByIds(List<int> ids) =>
      (select(persons)..where((tbl) => tbl.id.isIn(ids))).get();
}
