import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/Controller/User.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../DB/Database.dart';
import '../Model/Cart.dart' as Cart;

class LoginController extends GetxController {
  TextEditingController textUsernameC = TextEditingController();
  TextEditingController textPasswordC = TextEditingController();
  // UserController userController = Get.find<UserController>();

  @override
  void onInit() async {
    AppDatabase db = AppDatabase();
    var users = await db.select(db.users).get();
    var items = await db.select(db.items).get();
    var categories = await db.select(db.categories).get();
    var itemCategories = await db.select(db.itemCategories).get();
    var itemProperties = await db.select(db.itemProperties).get();
    var tables = await db.select(db.tables).get();
    var bills = await db.select(db.bills).get();
    var billItems = await db.select(db.billItems).get();
    var billItemProperties = await db.select(db.billItemProperties).get();

    Hive.registerAdapter(Cart.CartAdapter());
    Hive.registerAdapter(Cart.ItemAdapter());
    Hive.registerAdapter(Cart.CartItemAdapter());
    Hive.registerAdapter(Cart.CartItemPropertyAdapter());
    await Hive.initFlutter();

    var box = await Hive.openBox<List<Cart.Cart>>('testBox');

    Cart.CartItemProperty property = new Cart.CartItemProperty(
      name: 'Thêm mấy e đào',
      amount: 300.00,
    );

    Cart.Item item = new Cart.Item(
      id: 1,
      name: 'Trà đào',
      price: 300.00,
    );

    Cart.CartItem cartItem = new Cart.CartItem(
        quality: 3,
        price: 2,
        item: item,
        properties: List.generate(1, (index) => property));
    Cart.Cart cart =
        new Cart.Cart(tableId: 2, items: List.generate(1, (index) => cartItem));

    // box.add(List.generate(3, (index) => cart));

    var result = box.getAt(0);

    super.onInit();
  }
}
