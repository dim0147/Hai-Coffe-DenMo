import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';

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
                    color: AppConfig.HEADER_COLOR,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.restaurant_menu,
                      color: AppConfig.HEADER_COLOR,
                    ),
                  ),
                  TextSpan(
                    text: ' Menu',
                  )
                ],
              ),
            ),
            onTap: () {
              final menuScreenArgs = MenuScreenArgs();
              Get.offAllNamed('/menu', arguments: menuScreenArgs);
            },
          ),

          Divider(
            color: AppConfig.HEADER_COLOR,
          ),

          // TABLE
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.chair_alt,
                          color: AppConfig.HEADER_COLOR,
                        ),
                      ),
                      TextSpan(
                        text: ' Bàn',
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.airplay,
                          color: AppConfig.HEADER_COLOR,
                        ),
                      ),
                      TextSpan(
                        text: ' Bảng Điều Khiển',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.offAllNamed('/table/');
                },
              ),
              ListTile(
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.add,
                          color: AppConfig.HEADER_COLOR,
                        ),
                      ),
                      TextSpan(
                        text: ' Tạo bàn',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.offAllNamed('/table/add');
                },
              ),
            ],
          ),

          Divider(
            color: AppConfig.HEADER_COLOR,
          ),

          // CATEGORY
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppConfig.HEADER_COLOR,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.category,
                          color: AppConfig.HEADER_COLOR,
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
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.add,
                          color: AppConfig.HEADER_COLOR,
                        ),
                      ),
                      TextSpan(
                        text: ' Tạo danh mục',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.offAllNamed('/category/add');
                },
              ),
            ],
          ),

          Divider(
            color: AppConfig.HEADER_COLOR,
          ),

          // ITEM
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.fastfood,
                          color: AppConfig.HEADER_COLOR,
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
                        color: AppConfig.HEADER_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.add,
                          color: AppConfig.HEADER_COLOR,
                        ),
                      ),
                      TextSpan(
                        text: ' Tạo Item',
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Get.offAllNamed('/item/add');
                },
              ),
            ],
          ),

          Divider(
            color: AppConfig.HEADER_COLOR,
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

class RadioPrimary<T> extends StatelessWidget {
  const RadioPrimary(
      {Key? key,
      required this.title,
      required this.originValue,
      required this.valueChanged,
      required this.onChanged})
      : super(key: key);

  final String title;
  final T originValue;
  final T valueChanged;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Radio(
          value: originValue,
          groupValue: valueChanged,
          onChanged: onChanged,
        ),
        InkWell(
          onTap: () => onChanged(originValue),
          child: Text(title),
        ),
      ],
    );
  }
}
