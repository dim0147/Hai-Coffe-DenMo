import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/img/background.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          width: 250,
                          child: LinearProgressIndicator(
                            color: Color.fromRGBO(212, 112, 25, 1.0),
                            backgroundColor: Color.fromRGBO(237, 209, 159, 1.0),
                          ),
                        ),
                      ),
                      Text('Đang tải dữ liệu...'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
