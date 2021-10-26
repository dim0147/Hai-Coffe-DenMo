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
              child: Obx(() => Column(
                    children: [
                      if (controller.listPropertyAdded.length > 0)
                        ListProperty(),
                      AddCustomProperty(),
                      Amount(),
                      Divider(color: AppConfig.MAIN_COLOR, thickness: 2.0),
                      TotalPrice(),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class ListProperty extends GetView<AddSpecialItemController> {
  const ListProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chọn thuộc tính'),
        ),
        Obx(
          () => Column(
            children: [
              ...controller.listPropertyAdded
                  .map((e) => PropertyContainer(
                        property: e,
                      ))
                  .toList(),
              if (controller.totalProperty.value > 0)
                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tổng cộng: ${Utils.formatDouble(controller.totalProperty.value)}đ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}

class PropertyContainer extends GetView<AddSpecialItemController> {
  final PropertyAdded property;

  const PropertyContainer({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        if (property.quantity > 0)
                          TextSpan(
                              text: '${property.quantity}x',
                              style: TextStyle(color: Colors.green)),
                        WidgetSpan(
                            child: SizedBox(
                          width: 10.0,
                        )),
                        TextSpan(text: property.name),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: property.quantity > 0
                              ? '${Utils.formatDouble(property.showTotalPrice())}đ'
                              : '${property.amount.toString()}đ',
                          style: TextStyle(color: Colors.blueAccent)),
                      if (property.quantity > 0)
                        WidgetSpan(
                          child: IconButton(
                            color: Colors.red,
                            constraints:
                                BoxConstraints(maxWidth: 30, maxHeight: 30),
                            onPressed: () =>
                                controller.removeProperty(property),
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        )
                    ]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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

class Amount extends GetView<AddSpecialItemController> {
  const Amount({
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
              Flexible(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Số lượng'),
                  controller: TextEditingController(
                      text: controller.itemAmount.toString()),
                  onChanged: controller.onChangeItemAmount,
                ),
              ),
              Flexible(
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
              ),
              Flexible(
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
                              '${Utils.formatDouble(controller.cartItem.item.price)} đ',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Wrap(
                      children: [
                        Text(
                          '=',
                        ),
                        Text(
                          ' ${Utils.formatDouble(controller.totalDonGia.value)}đ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
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
        double allTotalPropertyMinusTotalDongia =
            (controller.totalProperty.value * controller.itemAmount.value);

        double allPrice =
            allTotalPropertyMinusTotalDongia + controller.totalDonGia.value;

        return Column(
          children: [
            Container(
              child: Column(
                children: [
                  if (controller.totalProperty.value > 0.0)
                    Text(
                      'Tổng thuộc tính: (${controller.totalProperty}đ * ${controller.itemAmount}) = ${allTotalPropertyMinusTotalDongia.toString()}đ +',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    'Tổng đơn giá: ${Utils.formatDouble(controller.totalDonGia.value)}đ',
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
              'Thành tiền: ${Utils.formatDouble(allPrice)} đ',
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
