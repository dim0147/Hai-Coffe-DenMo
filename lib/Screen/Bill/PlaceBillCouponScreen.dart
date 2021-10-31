import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/PlaceBillCouponController.dart';
import 'package:hai_noob/Model/Bill.dart';
import 'package:hai_noob/Screen/Component.dart';

class PlaceBillCouponScreen extends GetView<PlaceBillCouponController> {
  const PlaceBillCouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Coupon/Discount'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SubTotalWidget(),
                NameInput(),
                PriceAndPercentInputWidget(),
                RadioCouponType(),
                AddCouponBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameInput extends GetView<PlaceBillCouponController> {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller.nameC,
        decoration: InputDecoration(
          labelText: 'Nội dung',
          prefixIcon: Icon(Icons.library_add),
        ),
      ),
    );
  }
}

class PriceAndPercentInputWidget extends GetView<PlaceBillCouponController> {
  const PriceAndPercentInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: controller.onChangePrice,
            controller: controller.priceC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Giá',
              prefixIcon: Icon(
                Icons.local_offer,
              ),
            ),
          ),
        ),
        Text(
          '=',
          style: TextStyle(fontSize: 25.0),
        ),
        // Percent
        Expanded(
          child: TextField(
            controller: controller.percentC,
            onChanged: controller.onChangePercent,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Phần trăm (%)',
              prefixIcon: Icon(
                Icons.local_offer,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RadioCouponType extends GetView<PlaceBillCouponController> {
  const RadioCouponType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          RadioPrimary<CouponType>(
            title: 'Thêm',
            originValue: CouponType.increase,
            valueChanged: controller.couponType.value,
            onChanged: controller.onChangeCouponType,
          ),
          RadioPrimary<CouponType>(
            title: 'Giảm',
            originValue: CouponType.decrease,
            valueChanged: controller.couponType.value,
            onChanged: controller.onChangeCouponType,
          ),
        ],
      ),
    );
  }
}

class AddCouponBtn extends GetView<PlaceBillCouponController> {
  const AddCouponBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add
        ElevatedButton.icon(
          onPressed: controller.onAdd,
          icon: Icon(Icons.add),
          label: Text('Thêm'),
        ),
      ],
    );
  }
}

class SubTotalWidget extends GetView<PlaceBillCouponController> {
  const SubTotalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Text('Giá: ${Utils.formatDouble(controller.cart.showTotalPrice())}đ'),
    );
  }
}
