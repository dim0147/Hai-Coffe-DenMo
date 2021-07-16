import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/LoginController.dart';
import '../Model/User.dart';

class InputLoginScreen extends StatelessWidget {
  const InputLoginScreen(
      {Key? key,
      required this.title,
      this.onChanged,
      required this.icon,
      required this.textEditingController,
      this.obscureText,
      required this.mainColor})
      : super(key: key);

  final String title;
  final void Function(String)? onChanged;
  final Icon icon;
  final TextEditingController textEditingController;
  final bool? obscureText;
  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextField(
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: mainColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2.0),
          ),
          prefixIcon: icon,
        ),
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        controller: textEditingController,
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  const LoginBtn({Key? key, required this.onClick}) : super(key: key);

  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: onClick,
      child: Text(
        'Đăng Nhập',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.amber[300],
        ),
      ),
    );
  }
}

class LoginScreen extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = context.mediaQueryViewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: Container(
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
                new InputLoginScreen(
                  title: 'Username',
                  icon: Icon(Icons.person, color: controller.mainColor),
                  textEditingController: controller.textUsernameC,
                  mainColor: controller.mainColor,
                ),
                SizedBox(
                  height: 10,
                ),
                new InputLoginScreen(
                  title: 'Mật Khẩu',
                  icon: Icon(Icons.password, color: controller.mainColor),
                  textEditingController: controller.textPasswordC,
                  obscureText: true,
                  mainColor: controller.mainColor,
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
                    (state) => LoginBtn(
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
                            LoginBtn(
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
