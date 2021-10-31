import 'dart:io';

import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart' as db;
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class TestCase {
  Future seedBillData() async {
    final appDb = Get.find<db.AppDatabase>();
    final billDAO = BillDAO(appDb);
    final List<Future<int>> listTask = [];

    int totalBillToSeed = 1000;

    for (var i = 0; i < totalBillToSeed; i++) {
      final cart = gerenateCart();
      final task = billDAO.createBill(
        cart,
        BillPayment.Cash,
        [],
        cart.showTotalPrice(),
        randomTime(inYear: 2021),
      );
      listTask.add(task);
    }

    await Future.wait(listTask);
  }

  Cart gerenateCart() {
    final cart = Cart(items: genereListCartItem());
    return cart;
  }

  List<CartItem> genereListCartItem() {
    List<CartItem> list = [];
    int limit = Utils.randomExtension.randomNumber(1, 20);
    while (limit > 0) {
      final cartItem = CartItem(
          totalQuantity: Utils.randomExtension.randomNumber(0, 10),
          totalPrice:
              Utils.randomExtension.randomNumber(100000, 1000000).toDouble(),
          item: genereCartItem(),
          properties: []);
      list.add(cartItem);
      limit--;
    }
    return list;
  }

  Item genereCartItem() {
    return Item(
        id: Utils.randomExtension.randomNumber(0, 100),
        name: Utils.randomExtension.randomWords(),
        price: Utils.randomExtension.randomNumber(10000, 80000).toDouble(),
        img: '');
  }

  DateTime randomTime({
    required int inYear,
    int startMonth = 1,
    int endMonth = 12,
    int startDay = 1,
    int endDay = 30,
  }) {
    return DateTime(
        2021,
        Utils.randomExtension.randomNumber(startMonth, endMonth),
        Utils.randomExtension.randomNumber(startDay, endDay));
  }

  void testDBPath() async {
    final ExternalStorage = await getExternalStorageDirectory();
  }

  Future run() async {
    // await seedBillData();
    testDBPath();
  }
}
