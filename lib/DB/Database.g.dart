// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final Role role;
  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.role});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      role: $UsersTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}role']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    {
      final converter = $UsersTable.$converter0;
      map['role'] = Variable<int>(converter.mapToSql(role)!);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      role: Value(role),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      role: serializer.fromJson<Role>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'role': serializer.toJson<Role>(role),
    };
  }

  User copyWith({int? id, String? username, String? password, Role? role}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        role: role ?? this.role,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(username.hashCode, $mrjc(password.hashCode, role.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.role == this.role);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<Role> role;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.role = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.role = const Value.absent(),
  })  : username = Value(username),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<Role>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (role != null) 'role': role,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<Role>? role}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (role.present) {
      final converter = $UsersTable.$converter0;
      map['role'] = Variable<int>(converter.mapToSql(role.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 150),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _roleMeta = const VerificationMeta('role');
  late final GeneratedColumnWithTypeConverter<Role, int?> role =
      GeneratedColumn<int?>('role', aliasedName, false,
              typeName: 'INTEGER',
              requiredDuringInsert: false,
              defaultValue: Constant(Role.User.index))
          .withConverter<Role>($UsersTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, role];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    context.handle(_roleMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }

  static TypeConverter<Role, int> $converter0 =
      const EnumIndexConverter<Role>(Role.values);
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  Category({required this.id, required this.name});
  factory Category.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Category(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category copyWith({int? id, String? name}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, name.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CategoriesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 250),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Category.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(_db, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String name;
  final String image;
  final double price;
  final int? ancestorItemId;
  final bool visibility;
  final Status status;
  Item(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      this.ancestorItemId,
      required this.visibility,
      required this.status});
  factory Item.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Item(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      ancestorItemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ancestor_item_id']),
      visibility: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}visibility'])!,
      status: $ItemsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || ancestorItemId != null) {
      map['ancestor_item_id'] = Variable<int?>(ancestorItemId);
    }
    map['visibility'] = Variable<bool>(visibility);
    {
      final converter = $ItemsTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status)!);
    }
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
      price: Value(price),
      ancestorItemId: ancestorItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(ancestorItemId),
      visibility: Value(visibility),
      status: Value(status),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      price: serializer.fromJson<double>(json['price']),
      ancestorItemId: serializer.fromJson<int?>(json['ancestorItemId']),
      visibility: serializer.fromJson<bool>(json['visibility']),
      status: serializer.fromJson<Status>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'price': serializer.toJson<double>(price),
      'ancestorItemId': serializer.toJson<int?>(ancestorItemId),
      'visibility': serializer.toJson<bool>(visibility),
      'status': serializer.toJson<Status>(status),
    };
  }

  Item copyWith(
          {int? id,
          String? name,
          String? image,
          double? price,
          int? ancestorItemId,
          bool? visibility,
          Status? status}) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        ancestorItemId: ancestorItemId ?? this.ancestorItemId,
        visibility: visibility ?? this.visibility,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('ancestorItemId: $ancestorItemId, ')
          ..write('visibility: $visibility, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  price.hashCode,
                  $mrjc(ancestorItemId.hashCode,
                      $mrjc(visibility.hashCode, status.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.price == this.price &&
          other.ancestorItemId == this.ancestorItemId &&
          other.visibility == this.visibility &&
          other.status == this.status);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<double> price;
  final Value<int?> ancestorItemId;
  final Value<bool> visibility;
  final Value<Status> status;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.price = const Value.absent(),
    this.ancestorItemId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.status = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String image,
    required double price,
    this.ancestorItemId = const Value.absent(),
    this.visibility = const Value.absent(),
    required Status status,
  })  : name = Value(name),
        image = Value(image),
        price = Value(price),
        status = Value(status);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? price,
    Expression<int?>? ancestorItemId,
    Expression<bool>? visibility,
    Expression<Status>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (price != null) 'price': price,
      if (ancestorItemId != null) 'ancestor_item_id': ancestorItemId,
      if (visibility != null) 'visibility': visibility,
      if (status != null) 'status': status,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? image,
      Value<double>? price,
      Value<int?>? ancestorItemId,
      Value<bool>? visibility,
      Value<Status>? status}) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      ancestorItemId: ancestorItemId ?? this.ancestorItemId,
      visibility: visibility ?? this.visibility,
      status: status ?? this.status,
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
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (ancestorItemId.present) {
      map['ancestor_item_id'] = Variable<int?>(ancestorItemId.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<bool>(visibility.value);
    }
    if (status.present) {
      final converter = $ItemsTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('ancestorItemId: $ancestorItemId, ')
          ..write('visibility: $visibility, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 250),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _ancestorItemIdMeta =
      const VerificationMeta('ancestorItemId');
  late final GeneratedColumn<int?> ancestorItemId = GeneratedColumn<int?>(
      'ancestor_item_id', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES items(id)');
  final VerificationMeta _visibilityMeta = const VerificationMeta('visibility');
  late final GeneratedColumn<bool?> visibility = GeneratedColumn<bool?>(
      'visibility', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (visibility IN (0, 1))',
      defaultValue: Constant(true));
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumnWithTypeConverter<Status, int?> status =
      GeneratedColumn<int?>('status', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<Status>($ItemsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, image, price, ancestorItemId, visibility, status];
  @override
  String get aliasedName => _alias ?? 'items';
  @override
  String get actualTableName => 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
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
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('ancestor_item_id')) {
      context.handle(
          _ancestorItemIdMeta,
          ancestorItemId.isAcceptableOrUnknown(
              data['ancestor_item_id']!, _ancestorItemIdMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
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

  static TypeConverter<Status, int> $converter0 =
      const EnumIndexConverter<Status>(Status.values);
}

class ItemCategory extends DataClass implements Insertable<ItemCategory> {
  final int itemId;
  final int categoryId;
  ItemCategory({required this.itemId, required this.categoryId});
  factory ItemCategory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ItemCategory(
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      categoryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  ItemCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ItemCategoriesCompanion(
      itemId: Value(itemId),
      categoryId: Value(categoryId),
    );
  }

  factory ItemCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemCategory(
      itemId: serializer.fromJson<int>(json['itemId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  ItemCategory copyWith({int? itemId, int? categoryId}) => ItemCategory(
        itemId: itemId ?? this.itemId,
        categoryId: categoryId ?? this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('ItemCategory(')
          ..write('itemId: $itemId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(itemId.hashCode, categoryId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemCategory &&
          other.itemId == this.itemId &&
          other.categoryId == this.categoryId);
}

class ItemCategoriesCompanion extends UpdateCompanion<ItemCategory> {
  final Value<int> itemId;
  final Value<int> categoryId;
  const ItemCategoriesCompanion({
    this.itemId = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  ItemCategoriesCompanion.insert({
    required int itemId,
    required int categoryId,
  })  : itemId = Value(itemId),
        categoryId = Value(categoryId);
  static Insertable<ItemCategory> custom({
    Expression<int>? itemId,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  ItemCategoriesCompanion copyWith(
      {Value<int>? itemId, Value<int>? categoryId}) {
    return ItemCategoriesCompanion(
      itemId: itemId ?? this.itemId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemCategoriesCompanion(')
          ..write('itemId: $itemId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $ItemCategoriesTable extends ItemCategories
    with TableInfo<$ItemCategoriesTable, ItemCategory> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ItemCategoriesTable(this._db, [this._alias]);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES items(id)');
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  late final GeneratedColumn<int?> categoryId = GeneratedColumn<int?>(
      'category_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES categories(id)');
  @override
  List<GeneratedColumn> get $columns => [itemId, categoryId];
  @override
  String get aliasedName => _alias ?? 'item_categories';
  @override
  String get actualTableName => 'item_categories';
  @override
  VerificationContext validateIntegrity(Insertable<ItemCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId, categoryId};
  @override
  ItemCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ItemCategory.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemCategoriesTable createAlias(String alias) {
    return $ItemCategoriesTable(_db, alias);
  }
}

class ItemProperty extends DataClass implements Insertable<ItemProperty> {
  final int id;
  final int itemId;
  final String name;
  final double amount;
  ItemProperty(
      {required this.id,
      required this.itemId,
      required this.name,
      required this.amount});
  factory ItemProperty.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ItemProperty(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  ItemPropertiesCompanion toCompanion(bool nullToAbsent) {
    return ItemPropertiesCompanion(
      id: Value(id),
      itemId: Value(itemId),
      name: Value(name),
      amount: Value(amount),
    );
  }

  factory ItemProperty.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ItemProperty(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
    };
  }

  ItemProperty copyWith({int? id, int? itemId, String? name, double? amount}) =>
      ItemProperty(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ItemProperty(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(itemId.hashCode, $mrjc(name.hashCode, amount.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemProperty &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.amount == this.amount);
}

class ItemPropertiesCompanion extends UpdateCompanion<ItemProperty> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> name;
  final Value<double> amount;
  const ItemPropertiesCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ItemPropertiesCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String name,
    required double amount,
  })  : itemId = Value(itemId),
        name = Value(name),
        amount = Value(amount);
  static Insertable<ItemProperty> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? name,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
    });
  }

  ItemPropertiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? itemId,
      Value<String>? name,
      Value<double>? amount}) {
    return ItemPropertiesCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $ItemPropertiesTable extends ItemProperties
    with TableInfo<$ItemPropertiesTable, ItemProperty> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ItemPropertiesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES items(id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, itemId, name, amount];
  @override
  String get aliasedName => _alias ?? 'item_properties';
  @override
  String get actualTableName => 'item_properties';
  @override
  VerificationContext validateIntegrity(Insertable<ItemProperty> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemProperty map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ItemProperty.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ItemPropertiesTable createAlias(String alias) {
    return $ItemPropertiesTable(_db, alias);
  }
}

class Table extends DataClass implements Insertable<Table> {
  final int id;
  final String name;
  final int order;
  final TableStatus status;
  Table(
      {required this.id,
      required this.name,
      required this.order,
      required this.status});
  factory Table.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Table(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      order: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order'])!,
      status: $TablesTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['order'] = Variable<int>(order);
    {
      final converter = $TablesTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status)!);
    }
    return map;
  }

  TablesCompanion toCompanion(bool nullToAbsent) {
    return TablesCompanion(
      id: Value(id),
      name: Value(name),
      order: Value(order),
      status: Value(status),
    );
  }

  factory Table.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Table(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      order: serializer.fromJson<int>(json['order']),
      status: serializer.fromJson<TableStatus>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'order': serializer.toJson<int>(order),
      'status': serializer.toJson<TableStatus>(status),
    };
  }

  Table copyWith({int? id, String? name, int? order, TableStatus? status}) =>
      Table(
        id: id ?? this.id,
        name: name ?? this.name,
        order: order ?? this.order,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('Table(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('order: $order, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(order.hashCode, status.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Table &&
          other.id == this.id &&
          other.name == this.name &&
          other.order == this.order &&
          other.status == this.status);
}

class TablesCompanion extends UpdateCompanion<Table> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> order;
  final Value<TableStatus> status;
  const TablesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.order = const Value.absent(),
    this.status = const Value.absent(),
  });
  TablesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int order,
    this.status = const Value.absent(),
  })  : name = Value(name),
        order = Value(order);
  static Insertable<Table> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? order,
    Expression<TableStatus>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (order != null) 'order': order,
      if (status != null) 'status': status,
    });
  }

  TablesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? order,
      Value<TableStatus>? status}) {
    return TablesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      status: status ?? this.status,
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
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (status.present) {
      final converter = $TablesTable.$converter0;
      map['status'] = Variable<int>(converter.mapToSql(status.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TablesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('order: $order, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TablesTable extends Tables with TableInfo<$TablesTable, Table> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TablesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 250),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  late final GeneratedColumn<int?> order = GeneratedColumn<int?>(
      'order', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumnWithTypeConverter<TableStatus, int?> status =
      GeneratedColumn<int?>('status', aliasedName, false,
              typeName: 'INTEGER',
              requiredDuringInsert: false,
              defaultValue: Constant(TableStatus.Avaiable.index))
          .withConverter<TableStatus>($TablesTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, name, order, status];
  @override
  String get aliasedName => _alias ?? 'tables';
  @override
  String get actualTableName => 'tables';
  @override
  VerificationContext validateIntegrity(Insertable<Table> instance,
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
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Table map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Table.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TablesTable createAlias(String alias) {
    return $TablesTable(_db, alias);
  }

  static TypeConverter<TableStatus, int> $converter0 =
      const EnumIndexConverter<TableStatus>(TableStatus.values);
}

class Bill extends DataClass implements Insertable<Bill> {
  final int id;
  final int totalQuantities;
  final double? discount;
  final double totalPrice;
  final int issueId;
  final BillPayment payment;
  final DateTime createdAt;
  Bill(
      {required this.id,
      required this.totalQuantities,
      this.discount,
      required this.totalPrice,
      required this.issueId,
      required this.payment,
      required this.createdAt});
  factory Bill.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Bill(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      totalQuantities: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_quantities'])!,
      discount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}discount']),
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      issueId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}issue_id'])!,
      payment: $BillsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment']))!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_quantities'] = Variable<int>(totalQuantities);
    if (!nullToAbsent || discount != null) {
      map['discount'] = Variable<double?>(discount);
    }
    map['total_price'] = Variable<double>(totalPrice);
    map['issue_id'] = Variable<int>(issueId);
    {
      final converter = $BillsTable.$converter0;
      map['payment'] = Variable<int>(converter.mapToSql(payment)!);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      totalQuantities: Value(totalQuantities),
      discount: discount == null && nullToAbsent
          ? const Value.absent()
          : Value(discount),
      totalPrice: Value(totalPrice),
      issueId: Value(issueId),
      payment: Value(payment),
      createdAt: Value(createdAt),
    );
  }

  factory Bill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<int>(json['id']),
      totalQuantities: serializer.fromJson<int>(json['totalQuantities']),
      discount: serializer.fromJson<double?>(json['discount']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      issueId: serializer.fromJson<int>(json['issueId']),
      payment: serializer.fromJson<BillPayment>(json['payment']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalQuantities': serializer.toJson<int>(totalQuantities),
      'discount': serializer.toJson<double?>(discount),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'issueId': serializer.toJson<int>(issueId),
      'payment': serializer.toJson<BillPayment>(payment),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bill copyWith(
          {int? id,
          int? totalQuantities,
          double? discount,
          double? totalPrice,
          int? issueId,
          BillPayment? payment,
          DateTime? createdAt}) =>
      Bill(
        id: id ?? this.id,
        totalQuantities: totalQuantities ?? this.totalQuantities,
        discount: discount ?? this.discount,
        totalPrice: totalPrice ?? this.totalPrice,
        issueId: issueId ?? this.issueId,
        payment: payment ?? this.payment,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('totalQuantities: $totalQuantities, ')
          ..write('discount: $discount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('issueId: $issueId, ')
          ..write('payment: $payment, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          totalQuantities.hashCode,
          $mrjc(
              discount.hashCode,
              $mrjc(
                  totalPrice.hashCode,
                  $mrjc(issueId.hashCode,
                      $mrjc(payment.hashCode, createdAt.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.totalQuantities == this.totalQuantities &&
          other.discount == this.discount &&
          other.totalPrice == this.totalPrice &&
          other.issueId == this.issueId &&
          other.payment == this.payment &&
          other.createdAt == this.createdAt);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<int> id;
  final Value<int> totalQuantities;
  final Value<double?> discount;
  final Value<double> totalPrice;
  final Value<int> issueId;
  final Value<BillPayment> payment;
  final Value<DateTime> createdAt;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.totalQuantities = const Value.absent(),
    this.discount = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.issueId = const Value.absent(),
    this.payment = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BillsCompanion.insert({
    this.id = const Value.absent(),
    required int totalQuantities,
    this.discount = const Value.absent(),
    required double totalPrice,
    required int issueId,
    required BillPayment payment,
    this.createdAt = const Value.absent(),
  })  : totalQuantities = Value(totalQuantities),
        totalPrice = Value(totalPrice),
        issueId = Value(issueId),
        payment = Value(payment);
  static Insertable<Bill> custom({
    Expression<int>? id,
    Expression<int>? totalQuantities,
    Expression<double?>? discount,
    Expression<double>? totalPrice,
    Expression<int>? issueId,
    Expression<BillPayment>? payment,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalQuantities != null) 'total_quantities': totalQuantities,
      if (discount != null) 'discount': discount,
      if (totalPrice != null) 'total_price': totalPrice,
      if (issueId != null) 'issue_id': issueId,
      if (payment != null) 'payment': payment,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BillsCompanion copyWith(
      {Value<int>? id,
      Value<int>? totalQuantities,
      Value<double?>? discount,
      Value<double>? totalPrice,
      Value<int>? issueId,
      Value<BillPayment>? payment,
      Value<DateTime>? createdAt}) {
    return BillsCompanion(
      id: id ?? this.id,
      totalQuantities: totalQuantities ?? this.totalQuantities,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      issueId: issueId ?? this.issueId,
      payment: payment ?? this.payment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalQuantities.present) {
      map['total_quantities'] = Variable<int>(totalQuantities.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double?>(discount.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (issueId.present) {
      map['issue_id'] = Variable<int>(issueId.value);
    }
    if (payment.present) {
      final converter = $BillsTable.$converter0;
      map['payment'] = Variable<int>(converter.mapToSql(payment.value)!);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('id: $id, ')
          ..write('totalQuantities: $totalQuantities, ')
          ..write('discount: $discount, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('issueId: $issueId, ')
          ..write('payment: $payment, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, Bill> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BillsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _totalQuantitiesMeta =
      const VerificationMeta('totalQuantities');
  late final GeneratedColumn<int?> totalQuantities = GeneratedColumn<int?>(
      'total_quantities', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _discountMeta = const VerificationMeta('discount');
  late final GeneratedColumn<double?> discount = GeneratedColumn<double?>(
      'discount', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _issueIdMeta = const VerificationMeta('issueId');
  late final GeneratedColumn<int?> issueId = GeneratedColumn<int?>(
      'issue_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES users(id)');
  final VerificationMeta _paymentMeta = const VerificationMeta('payment');
  late final GeneratedColumnWithTypeConverter<BillPayment, int?> payment =
      GeneratedColumn<int?>('payment', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<BillPayment>($BillsTable.$converter0);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, totalQuantities, discount, totalPrice, issueId, payment, createdAt];
  @override
  String get aliasedName => _alias ?? 'bills';
  @override
  String get actualTableName => 'bills';
  @override
  VerificationContext validateIntegrity(Insertable<Bill> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_quantities')) {
      context.handle(
          _totalQuantitiesMeta,
          totalQuantities.isAcceptableOrUnknown(
              data['total_quantities']!, _totalQuantitiesMeta));
    } else if (isInserting) {
      context.missing(_totalQuantitiesMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('issue_id')) {
      context.handle(_issueIdMeta,
          issueId.isAcceptableOrUnknown(data['issue_id']!, _issueIdMeta));
    } else if (isInserting) {
      context.missing(_issueIdMeta);
    }
    context.handle(_paymentMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bill map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Bill.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(_db, alias);
  }

  static TypeConverter<BillPayment, int> $converter0 =
      const EnumIndexConverter<BillPayment>(BillPayment.values);
}

class BillItem extends DataClass implements Insertable<BillItem> {
  final int id;
  final int billId;
  final String itemName;
  final int quality;
  final double price;
  BillItem(
      {required this.id,
      required this.billId,
      required this.itemName,
      required this.quality,
      required this.price});
  factory BillItem.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BillItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      billId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bill_id'])!,
      itemName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_name'])!,
      quality: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quality'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['item_name'] = Variable<String>(itemName);
    map['quality'] = Variable<int>(quality);
    map['price'] = Variable<double>(price);
    return map;
  }

  BillItemsCompanion toCompanion(bool nullToAbsent) {
    return BillItemsCompanion(
      id: Value(id),
      billId: Value(billId),
      itemName: Value(itemName),
      quality: Value(quality),
      price: Value(price),
    );
  }

  factory BillItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BillItem(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      quality: serializer.fromJson<int>(json['quality']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'itemName': serializer.toJson<String>(itemName),
      'quality': serializer.toJson<int>(quality),
      'price': serializer.toJson<double>(price),
    };
  }

  BillItem copyWith(
          {int? id,
          int? billId,
          String? itemName,
          int? quality,
          double? price}) =>
      BillItem(
        id: id ?? this.id,
        billId: billId ?? this.billId,
        itemName: itemName ?? this.itemName,
        quality: quality ?? this.quality,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('BillItem(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('quality: $quality, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(billId.hashCode,
          $mrjc(itemName.hashCode, $mrjc(quality.hashCode, price.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItem &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.itemName == this.itemName &&
          other.quality == this.quality &&
          other.price == this.price);
}

class BillItemsCompanion extends UpdateCompanion<BillItem> {
  final Value<int> id;
  final Value<int> billId;
  final Value<String> itemName;
  final Value<int> quality;
  final Value<double> price;
  const BillItemsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.quality = const Value.absent(),
    this.price = const Value.absent(),
  });
  BillItemsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required String itemName,
    required int quality,
    required double price,
  })  : billId = Value(billId),
        itemName = Value(itemName),
        quality = Value(quality),
        price = Value(price);
  static Insertable<BillItem> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<String>? itemName,
    Expression<int>? quality,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (itemName != null) 'item_name': itemName,
      if (quality != null) 'quality': quality,
      if (price != null) 'price': price,
    });
  }

  BillItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? billId,
      Value<String>? itemName,
      Value<int>? quality,
      Value<double>? price}) {
    return BillItemsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      itemName: itemName ?? this.itemName,
      quality: quality ?? this.quality,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('quality: $quality, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $BillItemsTable extends BillItems
    with TableInfo<$BillItemsTable, BillItem> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BillItemsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _billIdMeta = const VerificationMeta('billId');
  late final GeneratedColumn<int?> billId = GeneratedColumn<int?>(
      'bill_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES bills(id)');
  final VerificationMeta _itemNameMeta = const VerificationMeta('itemName');
  late final GeneratedColumn<String?> itemName = GeneratedColumn<String?>(
      'item_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _qualityMeta = const VerificationMeta('quality');
  late final GeneratedColumn<int?> quality = GeneratedColumn<int?>(
      'quality', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, billId, itemName, quality, price];
  @override
  String get aliasedName => _alias ?? 'bill_items';
  @override
  String get actualTableName => 'bill_items';
  @override
  VerificationContext validateIntegrity(Insertable<BillItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(_billIdMeta,
          billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta));
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(_qualityMeta,
          quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta));
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BillItem.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BillItemsTable createAlias(String alias) {
    return $BillItemsTable(_db, alias);
  }
}

class BillItemPropertie extends DataClass
    implements Insertable<BillItemPropertie> {
  final int id;
  final int billItemId;
  final String name;
  final double amount;
  BillItemPropertie(
      {required this.id,
      required this.billItemId,
      required this.name,
      required this.amount});
  factory BillItemPropertie.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BillItemPropertie(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      billItemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bill_item_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_item_id'] = Variable<int>(billItemId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  BillItemPropertiesCompanion toCompanion(bool nullToAbsent) {
    return BillItemPropertiesCompanion(
      id: Value(id),
      billItemId: Value(billItemId),
      name: Value(name),
      amount: Value(amount),
    );
  }

  factory BillItemPropertie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BillItemPropertie(
      id: serializer.fromJson<int>(json['id']),
      billItemId: serializer.fromJson<int>(json['billItemId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billItemId': serializer.toJson<int>(billItemId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
    };
  }

  BillItemPropertie copyWith(
          {int? id, int? billItemId, String? name, double? amount}) =>
      BillItemPropertie(
        id: id ?? this.id,
        billItemId: billItemId ?? this.billItemId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('BillItemPropertie(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(billItemId.hashCode, $mrjc(name.hashCode, amount.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItemPropertie &&
          other.id == this.id &&
          other.billItemId == this.billItemId &&
          other.name == this.name &&
          other.amount == this.amount);
}

class BillItemPropertiesCompanion extends UpdateCompanion<BillItemPropertie> {
  final Value<int> id;
  final Value<int> billItemId;
  final Value<String> name;
  final Value<double> amount;
  const BillItemPropertiesCompanion({
    this.id = const Value.absent(),
    this.billItemId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BillItemPropertiesCompanion.insert({
    this.id = const Value.absent(),
    required int billItemId,
    required String name,
    required double amount,
  })  : billItemId = Value(billItemId),
        name = Value(name),
        amount = Value(amount);
  static Insertable<BillItemPropertie> custom({
    Expression<int>? id,
    Expression<int>? billItemId,
    Expression<String>? name,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billItemId != null) 'bill_item_id': billItemId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
    });
  }

  BillItemPropertiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? billItemId,
      Value<String>? name,
      Value<double>? amount}) {
    return BillItemPropertiesCompanion(
      id: id ?? this.id,
      billItemId: billItemId ?? this.billItemId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billItemId.present) {
      map['bill_item_id'] = Variable<int>(billItemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $BillItemPropertiesTable extends BillItemProperties
    with TableInfo<$BillItemPropertiesTable, BillItemPropertie> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BillItemPropertiesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _billItemIdMeta = const VerificationMeta('billItemId');
  late final GeneratedColumn<int?> billItemId = GeneratedColumn<int?>(
      'bill_item_id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES bill_items(id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, billItemId, name, amount];
  @override
  String get aliasedName => _alias ?? 'bill_item_properties';
  @override
  String get actualTableName => 'bill_item_properties';
  @override
  VerificationContext validateIntegrity(Insertable<BillItemPropertie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_item_id')) {
      context.handle(
          _billItemIdMeta,
          billItemId.isAcceptableOrUnknown(
              data['bill_item_id']!, _billItemIdMeta));
    } else if (isInserting) {
      context.missing(_billItemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItemPropertie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BillItemPropertie.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BillItemPropertiesTable createAlias(String alias) {
    return $BillItemPropertiesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemCategoriesTable itemCategories = $ItemCategoriesTable(this);
  late final $ItemPropertiesTable itemProperties = $ItemPropertiesTable(this);
  late final $TablesTable tables = $TablesTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillItemsTable billItems = $BillItemsTable(this);
  late final $BillItemPropertiesTable billItemProperties =
      $BillItemPropertiesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        categories,
        items,
        itemCategories,
        itemProperties,
        tables,
        bills,
        billItems,
        billItemProperties
      ];
}
