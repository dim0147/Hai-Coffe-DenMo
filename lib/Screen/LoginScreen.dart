import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';

import './Component.dart';
import '../Controller/LoginController.dart';
import '../Model/User.dart';

class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = context.mediaQueryViewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/img/background.png',
                  width: keyboardIsOpen ? 100 : 200,
                  height: keyboardIsOpen ? 100 : 200,
                ),
                Text(
                  'Đăng Nhập',
                  style: TextStyle(
                    color: AppConfig.HEADER_COLOR,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                  controller: controller.textUsernameC,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mật Khẩu',
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                  ),
                  controller: controller.textPasswordC,
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),

                // Save account
                Obx(
                  () => Center(
                    child: CheckboxPrimary(
                      title: 'Lưu Tài Khoản',
                      value: controller.saveAccount.value,
                      onChanged: controller.onSaveAccountCheckbox,
                    ),
                  ),
                ),

                // Button login
                controller.obx(
                    (state) => ElevatedButton(
                        onPressed: controller.onLoginClick,
                        child: Text('Đăng Nhập')),
                    onLoading: CircularProgressIndicator(
                      color: controller.mainColor,
                    ),
                    onError: (err) => Column(
                          children: [
                            Text(
                              err ?? 'Có lỗi xảy ra',
                              style: TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                                onPressed: controller.onLoginClick,
                                child: Text('Đăng Nhập')),
                          ],
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
