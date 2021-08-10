import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hai_noob/App/Config.dart';

Drawer NavigateMenu() {
  return Drawer(
    child: Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // HEADER
          DrawerHeader(
            child: Column(
              children: [
                Image.asset(
                  'assets/img/background.png',
                  width: Get.width * 0.8,
                  height: Get.height * 0.10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Bảng Điều Khiển'),
                )
              ],
            ),
          ),

          // MENU
          ListTile(
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.restaurant_menu,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' Menu',
                  )
                ],
              ),
            ),
            onTap: () {
              Get.back();
              Get.offAllNamed('/menu');
            },
          ),
          Divider(
            color: Get.theme.primaryColor,
          ),

          // CATEGORY
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.category,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' Danh Mục',
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.add,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' Tạo danh mục',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.offAllNamed('/category/add');
                },
              ),
            ],
          ),

          Divider(
            color: Get.theme.primaryColor,
          ),

          // ITEM
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.fastfood,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' Item',
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Get.theme.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.add,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' Tạo Item',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.offAllNamed('/item/add');
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class CheckboxPrimary extends StatelessWidget {
  const CheckboxPrimary(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String title;
  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        InkWell(
          onTap: () => onChanged(!value),
          child: Text(title),
        ),
      ],
    );
  }
}
