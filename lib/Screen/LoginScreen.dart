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
        backgroundColor: Get.theme.primaryColor,
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
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new PrimaryInput(
                  title: 'Username',
                  iconData: Icons.person,
                  textEditingController: controller.textUsernameC,
                  mainColor: AppConfig.MAIN_COLOR,
                ),
                SizedBox(
                  height: 10,
                ),
                new PrimaryInput(
                  title: 'Mật Khẩu',
                  iconData: Icons.password,
                  textEditingController: controller.textPasswordC,
                  obscureText: true,
                  mainColor: AppConfig.MAIN_COLOR,
                ),
                SizedBox(
                  height: 10,
                ),

                // Save account
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: controller.saveAccount.value,
                        activeColor: controller.mainColor,
                        onChanged: controller.onSaveAccountCheckbox,
                      ),
                      GestureDetector(
                        onTap: () => controller.onSaveAccountCheckbox(
                            !controller.saveAccount.value),
                        child: Text(
                          'Lưu Tài Khoản',
                          style: TextStyle(
                            color: controller.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Button login
                controller.obx(
                    (state) => PrimaryBtn(
                          title: 'Đăng Nhập',
                          onClick: controller.onLoginClick,
                        ),
                    onLoading: CircularProgressIndicator(
                      color: controller.mainColor,
                    ),
                    onError: (err) => Column(
                          children: [
                            Text(
                              err ?? 'Có lỗi xảy ra',
                              style: TextStyle(color: Colors.red),
                            ),
                            PrimaryBtn(
                              title: 'Đăng Nhập',
                              onClick: controller.onLoginClick,
                            ),
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
