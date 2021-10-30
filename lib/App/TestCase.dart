import 'dart:io';

import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart' as db;
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
    final ApplicationDocuments = await getApplicationDocumentsDirectory();

    if (ExternalStorage == null) return;
    createFolder('images');
    final adaad = await ExternalStorage.list().toList();
    var ad;
  }

  Future<dynamic> createFolder(String folderName) async {
    try {
      final externalStorage = await getExternalStorageDirectory();
      if (externalStorage == null) return Future.error('Null external');
      final String dir = p.join(externalStorage.path, folderName);

      final path = Directory(dir);
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   await Permission.storage.request();
      // }
      if ((await path.exists())) {
        return path.path;
      } else {
        print('create path');
        path.create();
        return path.path;
      }
    } catch (err) {
      var ad = err;
      var af;
    }
  }

  Future run() async {
    await seedBillData();
    testDBPath();
  }
}
