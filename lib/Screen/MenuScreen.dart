import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';

import 'package:hai_noob/Controller/MenuController.dart';

class MenuItem extends GetWidget<MenuController> {
  const MenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: Get.width * 0.3,
        // height: Get.height * 0.30,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/1200px-A_small_cup_of_coffee.JPG',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('Cà phê nhiều đường'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('10.000đ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
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
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[200],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.deepPurpleAccent,
                                  )),
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
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Select Table')),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Order')),
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
