import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/Controller/System/SystemInfo.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Component.dart';

class SystemInfoScreen extends GetView<SystemInfoController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Thông tin ứng dụng')),
        drawer: NavigateMenu(),
        body: Container(
          child: Center(
            child: Obx(
              () {
                final PackageInfo? packageInfo = controller.packageInfo.value;
                if (packageInfo == null) return CircularProgressIndicator();

                return Column(
                  children: [
                    Image(
                      image: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
                      width: Get.width * 0.3,
                    ),
                    Text('- Tên App: ${packageInfo.appName}'),
                    Text('- Version: ${packageInfo.version}'),
                    Text(
                      '- Github Repo: https://github.com/dim0147/Hai-Coffe-DenMo',
                    ),
                    Text(
                        '- Copyright 2021 ${String.fromCharCode(0x00A9)} Đứcc rồ'),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
