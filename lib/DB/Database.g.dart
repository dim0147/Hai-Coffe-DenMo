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
  Item(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      this.ancestorItemId,
      required this.visibility});
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
    };
  }

  Item copyWith(
          {int? id,
          String? name,
          String? image,
          double? price,
          int? ancestorItemId,
          bool? visibility}) =>
      Item(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        ancestorItemId: ancestorItemId ?? this.ancestorItemId,
        visibility: visibility ?? this.visibility,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('price: $price, ')
          ..write('ancestorItemId: $ancestorItemId, ')
          ..write('visibility: $visibility')
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
              $mrjc(price.hashCode,
                  $mrjc(ancestorItemId.hashCode, visibility.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.price == this.price &&
          other.ancestorItemId == this.ancestorItemId &&
          other.visibility == this.visibility);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<double> price;
  final Value<int?> ancestorItemId;
  final Value<bool> visibility;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.price = const Value.absent(),
    this.ancestorItemId = const Value.absent(),
    this.visibility = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String image,
    required double price,
    this.ancestorItemId = const Value.absent(),
    this.visibility = const Value.absent(),
  })  : name = Value(name),
        image = Value(image),
        price = Value(price);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
    Expression<double>? price,
    Expression<int?>? ancestorItemId,
    Expression<bool>? visibility,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (price != null) 'price': price,
      if (ancestorItemId != null) 'ancestor_item_id': ancestorItemId,
      if (visibility != null) 'visibility': visibility,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? image,
      Value<double>? price,
      Value<int?>? ancestorItemId,
      Value<bool>? visibility}) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      ancestorItemId: ancestorItemId ?? this.ancestorItemId,
      visibility: visibility ?? this.visibility,
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
          ..write('visibility: $visibility')
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
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, image, price, ancestorItemId, visibility];
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

class TableOrder extends DataClass implements Insertable<TableOrder> {
  final int id;
  final String name;
  final int order;
  TableOrder({required this.id, required this.name, required this.order});
  factory TableOrder.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TableOrder(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      order: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['order'] = Variable<int>(order);
    return map;
  }

  TableOrdersCompanion toCompanion(bool nullToAbsent) {
    return TableOrdersCompanion(
      id: Value(id),
      name: Value(name),
      order: Value(order),
    );
  }

  factory TableOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TableOrder(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'order': serializer.toJson<int>(order),
    };
  }

  TableOrder copyWith({int? id, String? name, int? order}) => TableOrder(
        id: id ?? this.id,
        name: name ?? this.name,
        order: order ?? this.order,
      );
  @override
  String toString() {
    return (StringBuffer('TableOrder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, order.hashCode)));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableOrder &&
          other.id == this.id &&
          other.name == this.name &&
          other.order == this.order);
}

class TableOrdersCompanion extends UpdateCompanion<TableOrder> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> order;
  const TableOrdersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.order = const Value.absent(),
  });
  TableOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int order,
  })  : name = Value(name),
        order = Value(order);
  static Insertable<TableOrder> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (order != null) 'order': order,
    });
  }

  TableOrdersCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? order}) {
    return TableOrdersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableOrdersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $TableOrdersTable extends TableOrders
    with TableInfo<$TableOrdersTable, TableOrder> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TableOrdersTable(this._db, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [id, name, order];
  @override
  String get aliasedName => _alias ?? 'table_orders';
  @override
  String get actualTableName => 'table_orders';
  @override
  VerificationContext validateIntegrity(Insertable<TableOrder> instance,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TableOrder.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TableOrdersTable createAlias(String alias) {
    return $TableOrdersTable(_db, alias);
  }
}

class Bill extends DataClass implements Insertable<Bill> {
  final int id;
  final int totalQuantities;
  final double subTotal;
  final double totalPrice;
  final BillPayment paymentType;
  final DateTime createdAt;
  Bill(
      {required this.id,
      required this.totalQuantities,
      required this.subTotal,
      required this.totalPrice,
      required this.paymentType,
      required this.createdAt});
  factory Bill.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Bill(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      totalQuantities: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_quantities'])!,
      subTotal: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sub_total'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      paymentType: $BillsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_type']))!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_quantities'] = Variable<int>(totalQuantities);
    map['sub_total'] = Variable<double>(subTotal);
    map['total_price'] = Variable<double>(totalPrice);
    {
      final converter = $BillsTable.$converter0;
      map['payment_type'] = Variable<int>(converter.mapToSql(paymentType)!);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      id: Value(id),
      totalQuantities: Value(totalQuantities),
      subTotal: Value(subTotal),
      totalPrice: Value(totalPrice),
      paymentType: Value(paymentType),
      createdAt: Value(createdAt),
    );
  }

  factory Bill.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Bill(
      id: serializer.fromJson<int>(json['id']),
      totalQuantities: serializer.fromJson<int>(json['totalQuantities']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      paymentType: serializer.fromJson<BillPayment>(json['paymentType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalQuantities': serializer.toJson<int>(totalQuantities),
      'subTotal': serializer.toJson<double>(subTotal),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'paymentType': serializer.toJson<BillPayment>(paymentType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bill copyWith(
          {int? id,
          int? totalQuantities,
          double? subTotal,
          double? totalPrice,
          BillPayment? paymentType,
          DateTime? createdAt}) =>
      Bill(
        id: id ?? this.id,
        totalQuantities: totalQuantities ?? this.totalQuantities,
        subTotal: subTotal ?? this.subTotal,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentType: paymentType ?? this.paymentType,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Bill(')
          ..write('id: $id, ')
          ..write('totalQuantities: $totalQuantities, ')
          ..write('subTotal: $subTotal, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('paymentType: $paymentType, ')
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
              subTotal.hashCode,
              $mrjc(totalPrice.hashCode,
                  $mrjc(paymentType.hashCode, createdAt.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          other.id == this.id &&
          other.totalQuantities == this.totalQuantities &&
          other.subTotal == this.subTotal &&
          other.totalPrice == this.totalPrice &&
          other.paymentType == this.paymentType &&
          other.createdAt == this.createdAt);
}

class BillsCompanion extends UpdateCompanion<Bill> {
  final Value<int> id;
  final Value<int> totalQuantities;
  final Value<double> subTotal;
  final Value<double> totalPrice;
  final Value<BillPayment> paymentType;
  final Value<DateTime> createdAt;
  const BillsCompanion({
    this.id = const Value.absent(),
    this.totalQuantities = const Value.absent(),
    this.subTotal = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BillsCompanion.insert({
    this.id = const Value.absent(),
    required int totalQuantities,
    required double subTotal,
    required double totalPrice,
    required BillPayment paymentType,
    this.createdAt = const Value.absent(),
  })  : totalQuantities = Value(totalQuantities),
        subTotal = Value(subTotal),
        totalPrice = Value(totalPrice),
        paymentType = Value(paymentType);
  static Insertable<Bill> custom({
    Expression<int>? id,
    Expression<int>? totalQuantities,
    Expression<double>? subTotal,
    Expression<double>? totalPrice,
    Expression<BillPayment>? paymentType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalQuantities != null) 'total_quantities': totalQuantities,
      if (subTotal != null) 'sub_total': subTotal,
      if (totalPrice != null) 'total_price': totalPrice,
      if (paymentType != null) 'payment_type': paymentType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BillsCompanion copyWith(
      {Value<int>? id,
      Value<int>? totalQuantities,
      Value<double>? subTotal,
      Value<double>? totalPrice,
      Value<BillPayment>? paymentType,
      Value<DateTime>? createdAt}) {
    return BillsCompanion(
      id: id ?? this.id,
      totalQuantities: totalQuantities ?? this.totalQuantities,
      subTotal: subTotal ?? this.subTotal,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentType: paymentType ?? this.paymentType,
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
    if (subTotal.present) {
      map['sub_total'] = Variable<double>(subTotal.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (paymentType.present) {
      final converter = $BillsTable.$converter0;
      map['payment_type'] =
          Variable<int>(converter.mapToSql(paymentType.value)!);
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
          ..write('subTotal: $subTotal, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('paymentType: $paymentType, ')
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
  final VerificationMeta _subTotalMeta = const VerificationMeta('subTotal');
  late final GeneratedColumn<double?> subTotal = GeneratedColumn<double?>(
      'sub_total', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  late final GeneratedColumnWithTypeConverter<BillPayment, int?> paymentType =
      GeneratedColumn<int?>('payment_type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<BillPayment>($BillsTable.$converter0);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, totalQuantities, subTotal, totalPrice, paymentType, createdAt];
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
    if (data.containsKey('sub_total')) {
      context.handle(_subTotalMeta,
          subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta));
    } else if (isInserting) {
      context.missing(_subTotalMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    context.handle(_paymentTypeMeta, const VerificationResult.success());
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
  final String itemImg;
  final double itemPrice;
  final int totalQuantity;
  final double totalPrice;
  final double totalPriceWithProperty;
  BillItem(
      {required this.id,
      required this.billId,
      required this.itemName,
      required this.itemImg,
      required this.itemPrice,
      required this.totalQuantity,
      required this.totalPrice,
      required this.totalPriceWithProperty});
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
      itemImg: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_img'])!,
      itemPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_price'])!,
      totalQuantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_quantity'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      totalPriceWithProperty: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_price_with_property'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['item_name'] = Variable<String>(itemName);
    map['item_img'] = Variable<String>(itemImg);
    map['item_price'] = Variable<double>(itemPrice);
    map['total_quantity'] = Variable<int>(totalQuantity);
    map['total_price'] = Variable<double>(totalPrice);
    map['total_price_with_property'] = Variable<double>(totalPriceWithProperty);
    return map;
  }

  BillItemsCompanion toCompanion(bool nullToAbsent) {
    return BillItemsCompanion(
      id: Value(id),
      billId: Value(billId),
      itemName: Value(itemName),
      itemImg: Value(itemImg),
      itemPrice: Value(itemPrice),
      totalQuantity: Value(totalQuantity),
      totalPrice: Value(totalPrice),
      totalPriceWithProperty: Value(totalPriceWithProperty),
    );
  }

  factory BillItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BillItem(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemImg: serializer.fromJson<String>(json['itemImg']),
      itemPrice: serializer.fromJson<double>(json['itemPrice']),
      totalQuantity: serializer.fromJson<int>(json['totalQuantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      totalPriceWithProperty:
          serializer.fromJson<double>(json['totalPriceWithProperty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'itemName': serializer.toJson<String>(itemName),
      'itemImg': serializer.toJson<String>(itemImg),
      'itemPrice': serializer.toJson<double>(itemPrice),
      'totalQuantity': serializer.toJson<int>(totalQuantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'totalPriceWithProperty':
          serializer.toJson<double>(totalPriceWithProperty),
    };
  }

  BillItem copyWith(
          {int? id,
          int? billId,
          String? itemName,
          String? itemImg,
          double? itemPrice,
          int? totalQuantity,
          double? totalPrice,
          double? totalPriceWithProperty}) =>
      BillItem(
        id: id ?? this.id,
        billId: billId ?? this.billId,
        itemName: itemName ?? this.itemName,
        itemImg: itemImg ?? this.itemImg,
        itemPrice: itemPrice ?? this.itemPrice,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        totalPrice: totalPrice ?? this.totalPrice,
        totalPriceWithProperty:
            totalPriceWithProperty ?? this.totalPriceWithProperty,
      );
  @override
  String toString() {
    return (StringBuffer('BillItem(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('itemImg: $itemImg, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalPriceWithProperty: $totalPriceWithProperty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          billId.hashCode,
          $mrjc(
              itemName.hashCode,
              $mrjc(
                  itemImg.hashCode,
                  $mrjc(
                      itemPrice.hashCode,
                      $mrjc(
                          totalQuantity.hashCode,
                          $mrjc(totalPrice.hashCode,
                              totalPriceWithProperty.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItem &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.itemName == this.itemName &&
          other.itemImg == this.itemImg &&
          other.itemPrice == this.itemPrice &&
          other.totalQuantity == this.totalQuantity &&
          other.totalPrice == this.totalPrice &&
          other.totalPriceWithProperty == this.totalPriceWithProperty);
}

class BillItemsCompanion extends UpdateCompanion<BillItem> {
  final Value<int> id;
  final Value<int> billId;
  final Value<String> itemName;
  final Value<String> itemImg;
  final Value<double> itemPrice;
  final Value<int> totalQuantity;
  final Value<double> totalPrice;
  final Value<double> totalPriceWithProperty;
  const BillItemsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemImg = const Value.absent(),
    this.itemPrice = const Value.absent(),
    this.totalQuantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.totalPriceWithProperty = const Value.absent(),
  });
  BillItemsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required String itemName,
    required String itemImg,
    required double itemPrice,
    required int totalQuantity,
    required double totalPrice,
    required double totalPriceWithProperty,
  })  : billId = Value(billId),
        itemName = Value(itemName),
        itemImg = Value(itemImg),
        itemPrice = Value(itemPrice),
        totalQuantity = Value(totalQuantity),
        totalPrice = Value(totalPrice),
        totalPriceWithProperty = Value(totalPriceWithProperty);
  static Insertable<BillItem> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<String>? itemName,
    Expression<String>? itemImg,
    Expression<double>? itemPrice,
    Expression<int>? totalQuantity,
    Expression<double>? totalPrice,
    Expression<double>? totalPriceWithProperty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (itemName != null) 'item_name': itemName,
      if (itemImg != null) 'item_img': itemImg,
      if (itemPrice != null) 'item_price': itemPrice,
      if (totalQuantity != null) 'total_quantity': totalQuantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (totalPriceWithProperty != null)
        'total_price_with_property': totalPriceWithProperty,
    });
  }

  BillItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? billId,
      Value<String>? itemName,
      Value<String>? itemImg,
      Value<double>? itemPrice,
      Value<int>? totalQuantity,
      Value<double>? totalPrice,
      Value<double>? totalPriceWithProperty}) {
    return BillItemsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      itemName: itemName ?? this.itemName,
      itemImg: itemImg ?? this.itemImg,
      itemPrice: itemPrice ?? this.itemPrice,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      totalPriceWithProperty:
          totalPriceWithProperty ?? this.totalPriceWithProperty,
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
    if (itemImg.present) {
      map['item_img'] = Variable<String>(itemImg.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<double>(itemPrice.value);
    }
    if (totalQuantity.present) {
      map['total_quantity'] = Variable<int>(totalQuantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (totalPriceWithProperty.present) {
      map['total_price_with_property'] =
          Variable<double>(totalPriceWithProperty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemName: $itemName, ')
          ..write('itemImg: $itemImg, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalPriceWithProperty: $totalPriceWithProperty')
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
  final VerificationMeta _itemImgMeta = const VerificationMeta('itemImg');
  late final GeneratedColumn<String?> itemImg = GeneratedColumn<String?>(
      'item_img', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _itemPriceMeta = const VerificationMeta('itemPrice');
  late final GeneratedColumn<double?> itemPrice = GeneratedColumn<double?>(
      'item_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _totalQuantityMeta =
      const VerificationMeta('totalQuantity');
  late final GeneratedColumn<int?> totalQuantity = GeneratedColumn<int?>(
      'total_quantity', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _totalPriceWithPropertyMeta =
      const VerificationMeta('totalPriceWithProperty');
  late final GeneratedColumn<double?> totalPriceWithProperty =
      GeneratedColumn<double?>('total_price_with_property', aliasedName, false,
          typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        billId,
        itemName,
        itemImg,
        itemPrice,
        totalQuantity,
        totalPrice,
        totalPriceWithProperty
      ];
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
    if (data.containsKey('item_img')) {
      context.handle(_itemImgMeta,
          itemImg.isAcceptableOrUnknown(data['item_img']!, _itemImgMeta));
    } else if (isInserting) {
      context.missing(_itemImgMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(_itemPriceMeta,
          itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta));
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
          _totalQuantityMeta,
          totalQuantity.isAcceptableOrUnknown(
              data['total_quantity']!, _totalQuantityMeta));
    } else if (isInserting) {
      context.missing(_totalQuantityMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('total_price_with_property')) {
      context.handle(
          _totalPriceWithPropertyMeta,
          totalPriceWithProperty.isAcceptableOrUnknown(
              data['total_price_with_property']!, _totalPriceWithPropertyMeta));
    } else if (isInserting) {
      context.missing(_totalPriceWithPropertyMeta);
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
  final double propertyPrice;
  final int totalQuantity;
  final double totalPrice;
  final double totalPriceMinusItemQuantity;
  BillItemPropertie(
      {required this.id,
      required this.billItemId,
      required this.name,
      required this.propertyPrice,
      required this.totalQuantity,
      required this.totalPrice,
      required this.totalPriceMinusItemQuantity});
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
      propertyPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}property_price'])!,
      totalQuantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_quantity'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      totalPriceMinusItemQuantity: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_price_minus_item_quantity'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_item_id'] = Variable<int>(billItemId);
    map['name'] = Variable<String>(name);
    map['property_price'] = Variable<double>(propertyPrice);
    map['total_quantity'] = Variable<int>(totalQuantity);
    map['total_price'] = Variable<double>(totalPrice);
    map['total_price_minus_item_quantity'] =
        Variable<double>(totalPriceMinusItemQuantity);
    return map;
  }

  BillItemPropertiesCompanion toCompanion(bool nullToAbsent) {
    return BillItemPropertiesCompanion(
      id: Value(id),
      billItemId: Value(billItemId),
      name: Value(name),
      propertyPrice: Value(propertyPrice),
      totalQuantity: Value(totalQuantity),
      totalPrice: Value(totalPrice),
      totalPriceMinusItemQuantity: Value(totalPriceMinusItemQuantity),
    );
  }

  factory BillItemPropertie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BillItemPropertie(
      id: serializer.fromJson<int>(json['id']),
      billItemId: serializer.fromJson<int>(json['billItemId']),
      name: serializer.fromJson<String>(json['name']),
      propertyPrice: serializer.fromJson<double>(json['propertyPrice']),
      totalQuantity: serializer.fromJson<int>(json['totalQuantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      totalPriceMinusItemQuantity:
          serializer.fromJson<double>(json['totalPriceMinusItemQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billItemId': serializer.toJson<int>(billItemId),
      'name': serializer.toJson<String>(name),
      'propertyPrice': serializer.toJson<double>(propertyPrice),
      'totalQuantity': serializer.toJson<int>(totalQuantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'totalPriceMinusItemQuantity':
          serializer.toJson<double>(totalPriceMinusItemQuantity),
    };
  }

  BillItemPropertie copyWith(
          {int? id,
          int? billItemId,
          String? name,
          double? propertyPrice,
          int? totalQuantity,
          double? totalPrice,
          double? totalPriceMinusItemQuantity}) =>
      BillItemPropertie(
        id: id ?? this.id,
        billItemId: billItemId ?? this.billItemId,
        name: name ?? this.name,
        propertyPrice: propertyPrice ?? this.propertyPrice,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        totalPrice: totalPrice ?? this.totalPrice,
        totalPriceMinusItemQuantity:
            totalPriceMinusItemQuantity ?? this.totalPriceMinusItemQuantity,
      );
  @override
  String toString() {
    return (StringBuffer('BillItemPropertie(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('name: $name, ')
          ..write('propertyPrice: $propertyPrice, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalPriceMinusItemQuantity: $totalPriceMinusItemQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          billItemId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  propertyPrice.hashCode,
                  $mrjc(
                      totalQuantity.hashCode,
                      $mrjc(totalPrice.hashCode,
                          totalPriceMinusItemQuantity.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItemPropertie &&
          other.id == this.id &&
          other.billItemId == this.billItemId &&
          other.name == this.name &&
          other.propertyPrice == this.propertyPrice &&
          other.totalQuantity == this.totalQuantity &&
          other.totalPrice == this.totalPrice &&
          other.totalPriceMinusItemQuantity ==
              this.totalPriceMinusItemQuantity);
}

class BillItemPropertiesCompanion extends UpdateCompanion<BillItemPropertie> {
  final Value<int> id;
  final Value<int> billItemId;
  final Value<String> name;
  final Value<double> propertyPrice;
  final Value<int> totalQuantity;
  final Value<double> totalPrice;
  final Value<double> totalPriceMinusItemQuantity;
  const BillItemPropertiesCompanion({
    this.id = const Value.absent(),
    this.billItemId = const Value.absent(),
    this.name = const Value.absent(),
    this.propertyPrice = const Value.absent(),
    this.totalQuantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.totalPriceMinusItemQuantity = const Value.absent(),
  });
  BillItemPropertiesCompanion.insert({
    this.id = const Value.absent(),
    required int billItemId,
    required String name,
    required double propertyPrice,
    required int totalQuantity,
    required double totalPrice,
    required double totalPriceMinusItemQuantity,
  })  : billItemId = Value(billItemId),
        name = Value(name),
        propertyPrice = Value(propertyPrice),
        totalQuantity = Value(totalQuantity),
        totalPrice = Value(totalPrice),
        totalPriceMinusItemQuantity = Value(totalPriceMinusItemQuantity);
  static Insertable<BillItemPropertie> custom({
    Expression<int>? id,
    Expression<int>? billItemId,
    Expression<String>? name,
    Expression<double>? propertyPrice,
    Expression<int>? totalQuantity,
    Expression<double>? totalPrice,
    Expression<double>? totalPriceMinusItemQuantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billItemId != null) 'bill_item_id': billItemId,
      if (name != null) 'name': name,
      if (propertyPrice != null) 'property_price': propertyPrice,
      if (totalQuantity != null) 'total_quantity': totalQuantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (totalPriceMinusItemQuantity != null)
        'total_price_minus_item_quantity': totalPriceMinusItemQuantity,
    });
  }

  BillItemPropertiesCompanion copyWith(
      {Value<int>? id,
      Value<int>? billItemId,
      Value<String>? name,
      Value<double>? propertyPrice,
      Value<int>? totalQuantity,
      Value<double>? totalPrice,
      Value<double>? totalPriceMinusItemQuantity}) {
    return BillItemPropertiesCompanion(
      id: id ?? this.id,
      billItemId: billItemId ?? this.billItemId,
      name: name ?? this.name,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      totalPriceMinusItemQuantity:
          totalPriceMinusItemQuantity ?? this.totalPriceMinusItemQuantity,
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
    if (propertyPrice.present) {
      map['property_price'] = Variable<double>(propertyPrice.value);
    }
    if (totalQuantity.present) {
      map['total_quantity'] = Variable<int>(totalQuantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (totalPriceMinusItemQuantity.present) {
      map['total_price_minus_item_quantity'] =
          Variable<double>(totalPriceMinusItemQuantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemPropertiesCompanion(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('name: $name, ')
          ..write('propertyPrice: $propertyPrice, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('totalPriceMinusItemQuantity: $totalPriceMinusItemQuantity')
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
  final VerificationMeta _propertyPriceMeta =
      const VerificationMeta('propertyPrice');
  late final GeneratedColumn<double?> propertyPrice = GeneratedColumn<double?>(
      'property_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _totalQuantityMeta =
      const VerificationMeta('totalQuantity');
  late final GeneratedColumn<int?> totalQuantity = GeneratedColumn<int?>(
      'total_quantity', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _totalPriceMinusItemQuantityMeta =
      const VerificationMeta('totalPriceMinusItemQuantity');
  late final GeneratedColumn<double?> totalPriceMinusItemQuantity =
      GeneratedColumn<double?>(
          'total_price_minus_item_quantity', aliasedName, false,
          typeName: 'REAL', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        billItemId,
        name,
        propertyPrice,
        totalQuantity,
        totalPrice,
        totalPriceMinusItemQuantity
      ];
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
    if (data.containsKey('property_price')) {
      context.handle(
          _propertyPriceMeta,
          propertyPrice.isAcceptableOrUnknown(
              data['property_price']!, _propertyPriceMeta));
    } else if (isInserting) {
      context.missing(_propertyPriceMeta);
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
          _totalQuantityMeta,
          totalQuantity.isAcceptableOrUnknown(
              data['total_quantity']!, _totalQuantityMeta));
    } else if (isInserting) {
      context.missing(_totalQuantityMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('total_price_minus_item_quantity')) {
      context.handle(
          _totalPriceMinusItemQuantityMeta,
          totalPriceMinusItemQuantity.isAcceptableOrUnknown(
              data['total_price_minus_item_quantity']!,
              _totalPriceMinusItemQuantityMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMinusItemQuantityMeta);
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

class BillCoupon extends DataClass implements Insertable<BillCoupon> {
  final int id;
  final int billId;
  final String name;
  final double price;
  final int percent;
  final CouponType couponType;
  BillCoupon(
      {required this.id,
      required this.billId,
      required this.name,
      required this.price,
      required this.percent,
      required this.couponType});
  factory BillCoupon.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BillCoupon(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      billId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bill_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      price: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price'])!,
      percent: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percent'])!,
      couponType: $BillCouponsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}coupon_type']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['percent'] = Variable<int>(percent);
    {
      final converter = $BillCouponsTable.$converter0;
      map['coupon_type'] = Variable<int>(converter.mapToSql(couponType)!);
    }
    return map;
  }

  BillCouponsCompanion toCompanion(bool nullToAbsent) {
    return BillCouponsCompanion(
      id: Value(id),
      billId: Value(billId),
      name: Value(name),
      price: Value(price),
      percent: Value(percent),
      couponType: Value(couponType),
    );
  }

  factory BillCoupon.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BillCoupon(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      percent: serializer.fromJson<int>(json['percent']),
      couponType: serializer.fromJson<CouponType>(json['couponType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'percent': serializer.toJson<int>(percent),
      'couponType': serializer.toJson<CouponType>(couponType),
    };
  }

  BillCoupon copyWith(
          {int? id,
          int? billId,
          String? name,
          double? price,
          int? percent,
          CouponType? couponType}) =>
      BillCoupon(
        id: id ?? this.id,
        billId: billId ?? this.billId,
        name: name ?? this.name,
        price: price ?? this.price,
        percent: percent ?? this.percent,
        couponType: couponType ?? this.couponType,
      );
  @override
  String toString() {
    return (StringBuffer('BillCoupon(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('percent: $percent, ')
          ..write('couponType: $couponType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          billId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(price.hashCode,
                  $mrjc(percent.hashCode, couponType.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillCoupon &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.name == this.name &&
          other.price == this.price &&
          other.percent == this.percent &&
          other.couponType == this.couponType);
}

class BillCouponsCompanion extends UpdateCompanion<BillCoupon> {
  final Value<int> id;
  final Value<int> billId;
  final Value<String> name;
  final Value<double> price;
  final Value<int> percent;
  final Value<CouponType> couponType;
  const BillCouponsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.percent = const Value.absent(),
    this.couponType = const Value.absent(),
  });
  BillCouponsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required String name,
    required double price,
    required int percent,
    required CouponType couponType,
  })  : billId = Value(billId),
        name = Value(name),
        price = Value(price),
        percent = Value(percent),
        couponType = Value(couponType);
  static Insertable<BillCoupon> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<String>? name,
    Expression<double>? price,
    Expression<int>? percent,
    Expression<CouponType>? couponType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (percent != null) 'percent': percent,
      if (couponType != null) 'coupon_type': couponType,
    });
  }

  BillCouponsCompanion copyWith(
      {Value<int>? id,
      Value<int>? billId,
      Value<String>? name,
      Value<double>? price,
      Value<int>? percent,
      Value<CouponType>? couponType}) {
    return BillCouponsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      name: name ?? this.name,
      price: price ?? this.price,
      percent: percent ?? this.percent,
      couponType: couponType ?? this.couponType,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (percent.present) {
      map['percent'] = Variable<int>(percent.value);
    }
    if (couponType.present) {
      final converter = $BillCouponsTable.$converter0;
      map['coupon_type'] = Variable<int>(converter.mapToSql(couponType.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillCouponsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('percent: $percent, ')
          ..write('couponType: $couponType')
          ..write(')'))
        .toString();
  }
}

class $BillCouponsTable extends BillCoupons
    with TableInfo<$BillCouponsTable, BillCoupon> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BillCouponsTable(this._db, [this._alias]);
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
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _priceMeta = const VerificationMeta('price');
  late final GeneratedColumn<double?> price = GeneratedColumn<double?>(
      'price', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _percentMeta = const VerificationMeta('percent');
  late final GeneratedColumn<int?> percent = GeneratedColumn<int?>(
      'percent', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _couponTypeMeta = const VerificationMeta('couponType');
  late final GeneratedColumnWithTypeConverter<CouponType, int?> couponType =
      GeneratedColumn<int?>('coupon_type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<CouponType>($BillCouponsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, billId, name, price, percent, couponType];
  @override
  String get aliasedName => _alias ?? 'bill_coupons';
  @override
  String get actualTableName => 'bill_coupons';
  @override
  VerificationContext validateIntegrity(Insertable<BillCoupon> instance,
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
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('percent')) {
      context.handle(_percentMeta,
          percent.isAcceptableOrUnknown(data['percent']!, _percentMeta));
    } else if (isInserting) {
      context.missing(_percentMeta);
    }
    context.handle(_couponTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillCoupon map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BillCoupon.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BillCouponsTable createAlias(String alias) {
    return $BillCouponsTable(_db, alias);
  }

  static TypeConverter<CouponType, int> $converter0 =
      const EnumIndexConverter<CouponType>(CouponType.values);
}

class Phieu extends DataClass implements Insertable<Phieu> {
  final int id;
  final double amount;
  final String reason;
  final PhieuType type;
  final DateTime createdAt;
  Phieu(
      {required this.id,
      required this.amount,
      required this.reason,
      required this.type,
      required this.createdAt});
  factory Phieu.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Phieu(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      reason: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reason'])!,
      type: $PhieusTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['reason'] = Variable<String>(reason);
    {
      final converter = $PhieusTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PhieusCompanion toCompanion(bool nullToAbsent) {
    return PhieusCompanion(
      id: Value(id),
      amount: Value(amount),
      reason: Value(reason),
      type: Value(type),
      createdAt: Value(createdAt),
    );
  }

  factory Phieu.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Phieu(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String>(json['reason']),
      type: serializer.fromJson<PhieuType>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String>(reason),
      'type': serializer.toJson<PhieuType>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Phieu copyWith(
          {int? id,
          double? amount,
          String? reason,
          PhieuType? type,
          DateTime? createdAt}) =>
      Phieu(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        reason: reason ?? this.reason,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Phieu(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(amount.hashCode,
          $mrjc(reason.hashCode, $mrjc(type.hashCode, createdAt.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phieu &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.type == this.type &&
          other.createdAt == this.createdAt);
}

class PhieusCompanion extends UpdateCompanion<Phieu> {
  final Value<int> id;
  final Value<double> amount;
  final Value<String> reason;
  final Value<PhieuType> type;
  final Value<DateTime> createdAt;
  const PhieusCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PhieusCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required String reason,
    required PhieuType type,
    this.createdAt = const Value.absent(),
  })  : amount = Value(amount),
        reason = Value(reason),
        type = Value(type);
  static Insertable<Phieu> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<PhieuType>? type,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PhieusCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<String>? reason,
      Value<PhieuType>? type,
      Value<DateTime>? createdAt}) {
    return PhieusCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (type.present) {
      final converter = $PhieusTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhieusCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PhieusTable extends Phieus with TableInfo<$PhieusTable, Phieu> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PhieusTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _reasonMeta = const VerificationMeta('reason');
  late final GeneratedColumn<String?> reason = GeneratedColumn<String?>(
      'reason', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<PhieuType, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<PhieuType>($PhieusTable.$converter0);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [id, amount, reason, type, createdAt];
  @override
  String get aliasedName => _alias ?? 'phieus';
  @override
  String get actualTableName => 'phieus';
  @override
  VerificationContext validateIntegrity(Insertable<Phieu> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Phieu map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Phieu.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PhieusTable createAlias(String alias) {
    return $PhieusTable(_db, alias);
  }

  static TypeConverter<PhieuType, int> $converter0 =
      const EnumIndexConverter<PhieuType>(PhieuType.values);
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemCategoriesTable itemCategories = $ItemCategoriesTable(this);
  late final $ItemPropertiesTable itemProperties = $ItemPropertiesTable(this);
  late final $TableOrdersTable tableOrders = $TableOrdersTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillItemsTable billItems = $BillItemsTable(this);
  late final $BillItemPropertiesTable billItemProperties =
      $BillItemPropertiesTable(this);
  late final $BillCouponsTable billCoupons = $BillCouponsTable(this);
  late final $PhieusTable phieus = $PhieusTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        categories,
        items,
        itemCategories,
        itemProperties,
        tableOrders,
        bills,
        billItems,
        billItemProperties,
        billCoupons,
        phieus
      ];
}
