import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/CartController.dart';

class CartScreen extends GetWidget<CartController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Giỏ Hàng')),
        bottomNavigationBar: Footer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Item
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              FadeInImage(
                                placeholder:
                                    AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                                image: Utils.getImg(''),
                                height: Get.height * 0.1,
                              ),
                              Text('Cà phê đường'),
                            ],
                          ),
                          Text('x5'),
                          Text('15.000đ'),
                        ],
                      ),

                      // Properties
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('+ Thêm dường'),
                              Text('x5'),
                              Text('10.000đ')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('+ Thêm dường'),
                              Text('x5'),
                              Text('10.000đ')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('+ Thêm dường'),
                              Text('x5'),
                              Text('10.000đ')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // Divider
                Divider(
                  color: AppConfig.MAIN_COLOR,
                ),

                // Item
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              FadeInImage(
                                placeholder:
                                    AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                                image: Utils.getImg(''),
                                height: Get.height * 0.1,
                              ),
                              Text('Cà phê đường'),
                            ],
                          ),
                          Text('x5'),
                          Text('15.000đ'),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider
                Divider(
                  color: AppConfig.MAIN_COLOR,
                ),

                // Total
                Container(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text('Tổng cộng: 100.000đ'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Footer extends GetView<CartController> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orangeAccent[200],
      ),
      child: Row(
        children: [
          // Cancel
          Expanded(
            flex: 3,
            child: OutlinedButton.icon(
              onPressed: controller.onCancelClick,
              icon: Icon(Icons.arrow_back),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 2.0, color: Get.theme.primaryColor.withOpacity(0.5)),
              ),
              label: Text('Quay Lại'),
            ),
          ),

          SizedBox(width: 5),

          // Payment
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.payment),
              label: Text('Payment'),
            ),
          )
        ],
      ),
    );
  }
}
