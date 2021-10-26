import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Model/Cart.dart';

class CouponScreenData {
  final String name;
  final double price;
  final int percent;
  final CouponType type;

  CouponScreenData(
      {required this.name,
      required this.price,
      required this.percent,
      required this.type});
}

class PlaceOrderCouponController extends GetxController {
  final cart = Get.arguments as Cart;
  final couponType = CouponType.decrease.obs;
  final nameC = TextEditingController();
  final priceC = MoneyMaskedTextController(
    precision: 0,
  );
  final percentC = TextEditingController();

  void onChangeCouponType(CouponType? value) {
    if (value == null) return;

    couponType.value = value;
  }

  void onChangePrice(String? value) {
    if (value == null) return;

    // Parse to int
    double price = priceC.numberValue;

    // Calculate percent
    var total = cart.showTotalPrice();
    int priceWithPercent = priceToPercent(price);
    percentC.text = priceWithPercent.toString();
  }

  void onChangePercent(String? value) {
    if (value == null) return;

    // Parse to int
    int? percent = int.tryParse(value);
    if (percent == null) return;

    // Calculate price
    var total = cart.showTotalPrice();
    double price = percentToPrice(percent);
    priceC.updateValue(price);
  }

  double percentToPrice(int percent) {
    double cartTotalPrice = cart.showTotalPrice();
    double priceWithPercent = (percent * cartTotalPrice) / 100;
    return priceWithPercent.toPrecision(2);
  }

  int priceToPercent(double price) {
    double cartTotalPrice = cart.showTotalPrice();
    double priceWithPercent = (price / cartTotalPrice) * 100;
    return priceWithPercent.toInt();
  }

  void onAdd() {
    String name = nameC.text;
    double price = priceC.numberValue;
    int? percent = int.tryParse(percentC.text);

    if (name.length == 0) {
      Utils.showSnackBar('Lỗi', 'Tên không hợp lệ');
      return;
    }

    if (price == 0.0 || percent == null) {
      Utils.showSnackBar('Lỗi', 'Giá hoặc phần trăm không hợp lệ');
      return;
    }

    CouponScreenData couponScreenData = CouponScreenData(
      name: name,
      price: price,
      percent: percent,
      type: couponType.value,
    );

    Get.back(result: couponScreenData);
  }
}
