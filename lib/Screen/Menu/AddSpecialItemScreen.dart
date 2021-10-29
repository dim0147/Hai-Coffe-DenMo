import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Menu/AddSpecialItemController.dart';

class AddSpecialItemScreen extends GetView<AddSpecialItemController> {
  const AddSpecialItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.cartItem.item.name),
        ),
        bottomNavigationBar: Footer(),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  PropertySection(),
                  ItemAmountSection(),
                  Divider(color: AppConfig.MAIN_COLOR, thickness: 2.0),
                  TotalPrice(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PropertySection extends GetView<AddSpecialItemController> {
  const PropertySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.listPropertyAdded.length == 0) return SizedBox();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chọn thuộc tính'),
        ),
        Column(
          children: [
            PropertyList(),
            TotalProperty(),
            AddCustomProperty(),
          ],
        ),
      ],
    );
  }
}

class PropertyList extends GetView<AddSpecialItemController> {
  const PropertyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: controller.listPropertyAdded
            .map((e) => PropertyItemList(
                  property: e,
                ))
            .toList(),
      ),
    );
  }
}

class PropertyItemList extends GetView<AddSpecialItemController> {
  final PropertyAdded property;

  const PropertyItemList({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool propertyHaveQuantity = property.quantity > 0;
    final double defaultPropertyPrice = property.amount;

    return InkWell(
      onTap: () => controller.increaseProperty(property),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppConfig.MAIN_COLOR,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.white)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PropertyQuantity(propertyHaveQuantity),
                RightSection(propertyHaveQuantity, defaultPropertyPrice),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding PropertyQuantity(bool propertyHaveQuantity) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          children: [
            // Display x2, x3,... if have quantity
            if (propertyHaveQuantity)
              TextSpan(
                text: '${property.quantity}x',
                style: TextStyle(color: Colors.green),
              ),
            WidgetSpan(
                child: SizedBox(
              width: 10.0,
            )),
            TextSpan(text: property.name),
          ],
        ),
      ),
    );
  }

  Padding RightSection(bool propertyHaveQuantity, double defaultPropertyPrice) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: RichText(
        text: TextSpan(children: [
          PropertyPrice(
            propertyHaveQuantity,
            defaultPropertyPrice,
          ),
          if (propertyHaveQuantity) PropertyDelBtn()
        ]),
      ),
    );
  }

  TextSpan PropertyPrice(
      bool propertyHaveQuantity, double defaultPropertyPrice) {
    return TextSpan(
      text: propertyHaveQuantity
          ? '${Utils.formatDouble(property.showTotalPrice())}đ'
          : '${Utils.formatDouble(defaultPropertyPrice)}đ',
      style: TextStyle(color: Colors.blueAccent),
    );
  }

  WidgetSpan PropertyDelBtn() {
    return WidgetSpan(
      child: IconButton(
        color: Colors.red,
        constraints: BoxConstraints(maxWidth: 30, maxHeight: 30),
        onPressed: () => controller.removeProperty(property),
        icon: Icon(
          Icons.delete,
        ),
      ),
    );
  }
}

class TotalProperty extends GetView<AddSpecialItemController> {
  const TotalProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.getTotalProperty() == 0.0) return SizedBox();
      return Row(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tổng cộng: ${Utils.formatDouble(controller.getTotalProperty())}đ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    });
  }
}

class AddCustomProperty extends GetView<AddSpecialItemController> {
  const AddCustomProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Thêm thuộc tính nhanh'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Thêm đường',
                    labelText: 'Tên',
                    prefixIcon: Icon(Icons.library_add),
                  ),
                  controller: controller.customNameC,
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Giá',
                    prefixIcon: Icon(
                      Icons.local_offer,
                    ),
                  ),
                  controller: controller.customAmountC,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ElevatedButton.icon(
              onPressed: controller.addCustomProperty,
              icon: Icon(Icons.add),
              label: Text('Thêm')),
        )
      ],
    );
  }
}

class ItemAmountSection extends GetView<AddSpecialItemController> {
  const ItemAmountSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              ItemAmountInput(),
              ItemAmountMinusSymbol(),
              ItemAmountSinglePrice(),
              ItemAmountSubTotal(),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemAmountInput extends GetView<AddSpecialItemController> {
  const ItemAmountInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String itemAmount = controller.itemAmount.toString();
    return Flexible(
      flex: 3,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Số lượng'),
        controller: TextEditingController(text: itemAmount),
        onChanged: controller.onChangeItemAmount,
      ),
    );
  }
}

class ItemAmountMinusSymbol extends StatelessWidget {
  const ItemAmountMinusSymbol({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'x',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ItemAmountSinglePrice extends GetView<AddSpecialItemController> {
  const ItemAmountSinglePrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemSinglePrice = controller.cartItem.item.price;
    return Flexible(
      flex: 8,
      fit: FlexFit.tight,
      child: Column(
        children: [
          Text('Đơn Giá'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: AppConfig.MAIN_COLOR),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${Utils.formatDouble(itemSinglePrice)} đ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemAmountSubTotal extends GetView<AddSpecialItemController> {
  const ItemAmountSubTotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Obx(() {
        final double itemSubtotal = controller.getItemSubTotal();

        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Wrap(
            children: [
              Text('='),
              Text(
                ' ${Utils.formatDouble(itemSubtotal)}đ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class TotalPrice extends GetView<AddSpecialItemController> {
  const TotalPrice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        final bool havePropertyPrice = controller.getTotalProperty() > 0.0;

        final double totalProperty = controller.getTotalProperty();
        final int itemAmount = controller.itemAmount.value;
        final double itemSubTotal = controller.getItemSubTotal();
        final double totalPropertyMinusItemQuantity =
            controller.totalPropertyMinusItemQuantity();
        final double totalPrice = controller.totalPrice();

        return Column(
          children: [
            Container(
              child: Column(
                children: [
                  if (havePropertyPrice)
                    Text(
                      'Tổng thuộc tính: (${Utils.formatDouble(totalProperty)}đ * $itemAmount) = ${Utils.formatDouble(totalPropertyMinusItemQuantity)}đ +',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    'Tổng đơn giá: ${Utils.formatDouble(itemSubTotal)}đ',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width / 2,
              child: Divider(
                color: AppConfig.MAIN_COLOR,
                thickness: 2.0,
              ),
            ),
            Text(
              'Thành tiền: ${Utils.formatDouble(totalPrice)} đ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class Footer extends GetView<AddSpecialItemController> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppConfig.MAIN_COLOR.withOpacity(0.5),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: controller.cancel,
              child: Text('Huỷ'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 2.0, color: AppConfig.MAIN_COLOR.withOpacity(0.5)),
              ),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: controller.confirm, child: Text('Xác nhận')),
          )),
        ],
      ),
    );
  }
}
