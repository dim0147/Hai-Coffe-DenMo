import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';

import 'package:hai_noob/Controller/MenuController.dart';
import 'package:hai_noob/Screen/Component.dart';

class MenuItem extends GetWidget<MenuController> {
  const MenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Get.width * 0.3,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1200px-A_small_cup_of_coffee.JPG',
              ),
            ),

            // Name
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('Cà phê nhiều đường'),
            ),

            // Price
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('10.000đ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),

            // Quality if have
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Get.theme.primaryColor),
                    children: [
                      TextSpan(text: 'Số lượng: '),
                      TextSpan(
                          text: '5',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),

            // Decrease quality
            IconButton(
              padding: EdgeInsets.all(4.0),
              onPressed: () {},
              icon: Icon(
                Icons.remove,
                color: Get.theme.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends GetWidget<MenuController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        drawer: NavigateMenu(),
        body: Container(
          child: Obx(() => controller.isLoading.value
              ? SizedBox.expand(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10.0),
                      Text('Đang tải dữ liệu')
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Get.theme.primaryColor,
                      tabs: controller.tabs,
                      controller: controller.tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tabs
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [
                                        MenuItem(),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [
                                      MenuItem(),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                        controller: controller.tabController,
                      ),
                    ),

                    // Footer
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[200],
                      ),
                      child: Row(
                        children: [
                          // Cart quality badge
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              Positioned(
                                child: new Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: new BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),

                          // Select table
                          Expanded(
                            flex: 3,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.table_chart),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 2.0,
                                    color: Get.theme.primaryColor
                                        .withOpacity(0.5)),
                              ),
                              label: Text('Chọn Bàn'),
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
                    )
                  ],
                )),
        ),
      ),
    );
  }
}
