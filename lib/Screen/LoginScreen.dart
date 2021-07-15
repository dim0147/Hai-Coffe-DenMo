import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/User.dart';
import '../Controller/Login.dart';
import '../Model/User.dart';

class InputLoginScreen extends StatelessWidget {
  const InputLoginScreen({
    Key? key,
    required this.title,
    this.onChanged,
    required this.icon,
    required this.textEditingController,
    this.obscureText,
  }) : super(key: key);

  final String title;
  final void Function(String)? onChanged;
  final Icon icon;
  final TextEditingController textEditingController;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          labelText: title,
          prefixIcon: icon,
        ),
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        controller: textEditingController,
      ),
    );
  }
}

class LoginScreen extends GetWidget<LoginController> {
  void onPressLoginBtn(BuildContext context) {
    Get.snackbar('Test', 'Click');
    print(
        'Username: ${controller.textUsernameC.text}, Password: ${controller.textPasswordC.text}');
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 250,
                  height: 250,
                ),
                Text(
                  'Login',
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
                  icon: Icon(Icons.person),
                  textEditingController: controller.textUsernameC,
                ),
                SizedBox(
                  height: 10,
                ),
                new InputLoginScreen(
                  title: 'Mật Khẩu',
                  icon: Icon(Icons.password),
                  textEditingController: controller.textPasswordC,
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    onPressLoginBtn(context);
                  },
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
