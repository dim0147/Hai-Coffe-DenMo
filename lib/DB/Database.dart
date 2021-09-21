// <Implement>
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
// </Implement>
import 'package:moor/moor.dart';

import '../DAO/UserDAO.dart';
import '../Model/User.dart';
import '../Model/Category.dart';
import '../Model/Item.dart';
import '../Model/TableOrders.dart';
import '../Model/Bill.dart';

part 'Database.g.dart';

// <Implement>
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
// </Implement>

// <Implement>
@UseMoor(tables: [
  Users,
  Categories,
  Items,
  ItemCategories,
  ItemProperties,
  TableOrders,
  Bills,
  BillItems,
  BillItemProperties,
  BillCoupons
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  void insertTest() async {
    into(users)
        .insert(UsersCompanion.insert(username: 'Admon', password: '1234567'));

    into(categories).insert(CategoriesCompanion.insert(name: 'Đồ Ăn'));

    into(items).insert(ItemsCompanion.insert(
        name: 'Trứng',
        image: 'trung.jpg',
        price: 300.000,
        status: Status.InStock));

    into(itemCategories)
        .insert(ItemCategoriesCompanion.insert(itemId: 1, categoryId: 1));

    into(itemProperties).insert(ItemPropertiesCompanion.insert(
        itemId: 1, name: 'Thêm đường', amount: 3000.50));

    into(tableOrders)
        .insert(TableOrdersCompanion.insert(name: 'Bàn 1', order: 1));

    into(bills).insert(BillsCompanion.insert(
        subTotal: 10.0,
        totalQuantities: 10,
        totalPrice: 1000,
        paymentType: BillPayment.Cash));
    into(billItems).insert(BillItemsCompanion.insert(
        itemImg: '',
        billId: 1,
        itemName: 'Bia 333',
        itemPrice: 30.0,
        totalQuantity: 10,
        totalPrice: 100));

    into(billItemProperties).insert(BillItemPropertiesCompanion.insert(
        billItemId: 1,
        name: 'Thêm muối',
        propertyPrice: 10,
        totalQuantity: 1,
        totalPrice: 300.00));
  }

  void _seedData() async {
    UserDAO userDAO = UserDAO(this);

    // Create admin account
    await userDAO.createAdminAccount();
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        print('onCreate');
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        print('onUpgrade');
      }, beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (details.wasCreated) {
          print('First Time Init Database, Start Seed Data');
          _seedData();
        }

        print('beforeOpen');
      });
}




// </Implement>

// <MockData>

// @UseMoor(tables: [
//   Users,
//   Categories,
//   Items,
//   ItemCategories,
//   ItemProperties,
//   Tables,
//   Bills,
//   BillItems,
//   BillItemProperties
// ])
// class AppDatabase {}

// </MockData>
