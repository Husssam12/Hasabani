// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String name;
  final int imageID;
  final double deserved;
  Person(
      {required this.id,
      required this.name,
      required this.imageID,
      required this.deserved});
  factory Person.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Person(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      imageID: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_i_d'])!,
      deserved: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deserved'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_i_d'] = Variable<int>(imageID);
    map['deserved'] = Variable<double>(deserved);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      name: Value(name),
      imageID: Value(imageID),
      deserved: Value(deserved),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageID: serializer.fromJson<int>(json['imageID']),
      deserved: serializer.fromJson<double>(json['deserved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageID': serializer.toJson<int>(imageID),
      'deserved': serializer.toJson<double>(deserved),
    };
  }

  Person copyWith({int? id, String? name, int? imageID, double? deserved}) =>
      Person(
        id: id ?? this.id,
        name: name ?? this.name,
        imageID: imageID ?? this.imageID,
        deserved: deserved ?? this.deserved,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageID: $imageID, ')
          ..write('deserved: $deserved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(imageID.hashCode, deserved.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageID == this.imageID &&
          other.deserved == this.deserved);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> imageID;
  final Value<double> deserved;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageID = const Value.absent(),
    this.deserved = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.imageID = const Value.absent(),
    this.deserved = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Person> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? imageID,
    Expression<double>? deserved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageID != null) 'image_i_d': imageID,
      if (deserved != null) 'deserved': deserved,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? imageID,
      Value<double>? deserved}) {
    return PersonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageID: imageID ?? this.imageID,
      deserved: deserved ?? this.deserved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageID.present) {
      map['image_i_d'] = Variable<int>(imageID.value);
    }
    if (deserved.present) {
      map['deserved'] = Variable<double>(deserved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageID: $imageID, ')
          ..write('deserved: $deserved')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PersonsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageIDMeta = const VerificationMeta('imageID');
  @override
  late final GeneratedIntColumn imageID = _constructImageID();
  GeneratedIntColumn _constructImageID() {
    return GeneratedIntColumn('image_i_d', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _deservedMeta = const VerificationMeta('deserved');
  @override
  late final GeneratedRealColumn deserved = _constructDeserved();
  GeneratedRealColumn _constructDeserved() {
    return GeneratedRealColumn('deserved', $tableName, false,
        defaultValue: Constant(0.0));
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, imageID, deserved];
  @override
  $PersonsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'persons';
  @override
  final String actualTableName = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_i_d')) {
      context.handle(_imageIDMeta,
          imageID.isAcceptableOrUnknown(data['image_i_d']!, _imageIDMeta));
    }
    if (data.containsKey('deserved')) {
      context.handle(_deservedMeta,
          deserved.isAcceptableOrUnknown(data['deserved']!, _deservedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Person.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(_db, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String label;
  final int price;
  final int personId;
  final DateTime date;
  Item(
      {required this.id,
      required this.label,
      required this.price,
      required this.personId,
      required this.date});
  factory Item.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Item(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      label: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}label'])!,
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      personId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}person_id'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['price'] = Variable<int>(price);
    map['person_id'] = Variable<int>(personId);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      label: Value(label),
      price: Value(price),
      personId: Value(personId),
      date: Value(date),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      price: serializer.fromJson<int>(json['price']),
      personId: serializer.fromJson<int>(json['personId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'price': serializer.toJson<int>(price),
      'personId': serializer.toJson<int>(personId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Item copyWith(
          {int? id,
          String? label,
          int? price,
          int? personId,
          DateTime? date}) =>
      Item(
        id: id ?? this.id,
        label: label ?? this.label,
        price: price ?? this.price,
        personId: personId ?? this.personId,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('price: $price, ')
          ..write('personId: $personId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(label.hashCode,
          $mrjc(price.hashCode, $mrjc(personId.hashCode, date.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.label == this.label &&
          other.price == this.price &&
          other.personId == this.personId &&
          other.date == this.date);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> label;
  final Value<int> price;
  final Value<int> personId;
  final Value<DateTime> date;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.price = const Value.absent(),
    this.personId = const Value.absent(),
    this.date = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required int price,
    required int personId,
    required DateTime date,
  })  : label = Value(label),
        price = Value(price),
        personId = Value(personId),
        date = Value(date);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<int>? price,
    Expression<int>? personId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (price != null) 'price': price,
      if (personId != null) 'person_id': personId,
      if (date != null) 'date': date,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? label,
      Value<int>? price,
      Value<int>? personId,
      Value<DateTime>? date}) {
    return ItemsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      price: price ?? this.price,
      personId: personId ?? this.personId,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('price: $price, ')
          ..write('personId: $personId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedTextColumn label = _constructLabel();
  GeneratedTextColumn _constructLabel() {
    return GeneratedTextColumn(
      'label',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedIntColumn price = _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _personIdMeta = const VerificationMeta('personId');
  @override
  late final GeneratedIntColumn personId = _constructPersonId();
  GeneratedIntColumn _constructPersonId() {
    return GeneratedIntColumn('person_id', $tableName, false,
        $customConstraints: 'REFERENCES persons(id)');
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedDateTimeColumn date = _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, label, price, personId, date];
  @override
  $ItemsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'items';
  @override
  final String actualTableName = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Item.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(_db, alias);
  }
}

class ItemsDetail extends DataClass implements Insertable<ItemsDetail> {
  final int personId;
  final int itemId;
  ItemsDetail({required this.personId, required this.itemId});
  factory ItemsDetail.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ItemsDetail(
      personId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}person_id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['person_id'] = Variable<int>(personId);
    map['item_id'] = Variable<int>(itemId);
    return map;
  }

  ItemsDetailsCompanion toCompanion(bool nullToAbsent) {
    return ItemsDetailsCompanion(
      personId: Value(personId),
      itemId: Value(itemId),
    );
  }

  factory ItemsDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemsDetail(
      personId: serializer.fromJson<int>(json['personId']),
      itemId: serializer.fromJson<int>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'personId': serializer.toJson<int>(personId),
      'itemId': serializer.toJson<int>(itemId),
    };
  }

  ItemsDetail copyWith({int? personId, int? itemId}) => ItemsDetail(
        personId: personId ?? this.personId,
        itemId: itemId ?? this.itemId,
      );
  @override
  String toString() {
    return (StringBuffer('ItemsDetail(')
          ..write('personId: $personId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(personId.hashCode, itemId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemsDetail &&
          other.personId == this.personId &&
          other.itemId == this.itemId);
}

class ItemsDetailsCompanion extends UpdateCompanion<ItemsDetail> {
  final Value<int> personId;
  final Value<int> itemId;
  const ItemsDetailsCompanion({
    this.personId = const Value.absent(),
    this.itemId = const Value.absent(),
  });
  ItemsDetailsCompanion.insert({
    required int personId,
    required int itemId,
  })  : personId = Value(personId),
        itemId = Value(itemId);
  static Insertable<ItemsDetail> custom({
    Expression<int>? personId,
    Expression<int>? itemId,
  }) {
    return RawValuesInsertable({
      if (personId != null) 'person_id': personId,
      if (itemId != null) 'item_id': itemId,
    });
  }

  ItemsDetailsCompanion copyWith({Value<int>? personId, Value<int>? itemId}) {
    return ItemsDetailsCompanion(
      personId: personId ?? this.personId,
      itemId: itemId ?? this.itemId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsDetailsCompanion(')
          ..write('personId: $personId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }
}

class $ItemsDetailsTable extends ItemsDetails
    with TableInfo<$ItemsDetailsTable, ItemsDetail> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ItemsDetailsTable(this._db, [this._alias]);
  final VerificationMeta _personIdMeta = const VerificationMeta('personId');
  @override
  late final GeneratedIntColumn personId = _constructPersonId();
  GeneratedIntColumn _constructPersonId() {
    return GeneratedIntColumn('person_id', $tableName, false,
        $customConstraints: 'REFERENCES persons(id)');
  }

  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedIntColumn itemId = _constructItemId();
  GeneratedIntColumn _constructItemId() {
    return GeneratedIntColumn('item_id', $tableName, false,
        $customConstraints: 'REFERENCES items(id) ON DELETE CASCADE');
  }

  @override
  List<GeneratedColumn> get $columns => [personId, itemId];
  @override
  $ItemsDetailsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'items_details';
  @override
  final String actualTableName = 'items_details';
  @override
  VerificationContext validateIntegrity(Insertable<ItemsDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ItemsDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ItemsDetail.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemsDetailsTable createAlias(String alias) {
    return $ItemsDetailsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemsDetailsTable itemsDetails = $ItemsDetailsTable(this);
  late final PersonsDao personsDao = PersonsDao(this as AppDatabase);
  late final ItemsDao itemsDao = ItemsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [persons, items, itemsDetails];
}
