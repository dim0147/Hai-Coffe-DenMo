import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/Menu/MenuController.dart';

Widget NavigateMenu() {
  return Drawer(
    child: Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // HEADER
          HeaderMenu(),

          MainMenu(),
          RevenueMenu(),
          MenuDivider(),

          TableMenu(),
          MenuDivider(),

          BillMenu(),
          MenuDivider(),

          PhieuMenu(),
          MenuDivider(),

          MenuItem(),
          MenuDivider(),

          CategoryMenu(),
          MenuDivider(),

          SystemMenu(),
        ],
      ),
    ),
  );
}

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
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
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        Get.offNamed('/menu', arguments: menuScreenArgs);
      },
    );
  }
}

class RevenueMenu extends StatelessWidget {
  const RevenueMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: TextStyle(
              color: AppConfig.HEADER_COLOR,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          children: [
            WidgetSpan(
              child: Icon(
                Icons.bar_chart,
                color: AppConfig.HEADER_COLOR,
              ),
            ),
            TextSpan(
              text: ' Doanh thu',
            )
          ],
        ),
      ),
      onTap: () {
        Get.offNamed('/revenue');
      },
    );
  }
}

class TableMenu extends StatelessWidget {
  const TableMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Get.offNamed('/table/');
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
            Get.offNamed('/table/add');
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
                    Icons.edit,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Chỉnh sửa',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/table/list');
          },
        ),
      ],
    );
  }
}

class BillMenu extends StatelessWidget {
  const BillMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Icons.receipt,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Bill',
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
                    Icons.receipt_outlined,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Xem Bill',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/bill/list');
          },
        ),
      ],
    );
  }
}

class PhieuMenu extends StatelessWidget {
  const PhieuMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Icons.confirmation_num,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Phiếu',
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
                  text: ' Tạo phiếu',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/phieu/add');
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
                    Icons.receipt_long,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Xem phiếu',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/phieu/list');
          },
        ),
      ],
    );
  }
}

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Get.offNamed('/category/add');
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
                    Icons.edit,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Chỉnh sửa',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/category/list');
          },
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Get.offNamed('/item/add');
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
                    Icons.edit,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Chỉnh sủa',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/item/list');
          },
        ),
      ],
    );
  }
}

class SystemMenu extends StatelessWidget {
  const SystemMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Icons.settings,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Hệ thống',
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
                    Icons.import_export,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Import/Export',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/system/import-export');
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
                    Icons.info,
                    color: AppConfig.HEADER_COLOR,
                  ),
                ),
                TextSpan(
                  text: ' Thông tin ứng dụng',
                )
              ],
            ),
          ),
          onTap: () {
            Get.offNamed('/system/info');
          },
        ),
      ],
    );
  }
}

class MenuDivider extends StatelessWidget {
  const MenuDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppConfig.HEADER_COLOR,
    );
  }
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
