import 'package:flutter/material.dart';
import 'package:hai_noob/App/Config.dart';

class PrimaryInput extends StatelessWidget {
  const PrimaryInput(
      {Key? key,
      required this.title,
      this.onChanged,
      required this.iconData,
      required this.textEditingController,
      this.obscureText,
      required this.mainColor})
      : super(key: key);

  final String title;
  final void Function(String)? onChanged;
  final IconData iconData;
  final TextEditingController textEditingController;
  final bool? obscureText;
  final Color? mainColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        prefixIcon: Icon(
          iconData,
          color: AppConfig.TEXT_BTN_COLOR,
        ),
      ),
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      controller: textEditingController,
    );
  }
}

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({Key? key, required this.onClick, required this.title})
      : super(key: key);

  final String title;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        backgroundColor:
            MaterialStateProperty.all<Color?>(AppConfig.MAIN_COLOR),
      ),
      onPressed: onClick,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.yellowAccent[100],
        ),
      ),
    );
  }
}

class PrimaryBtnIcon extends StatelessWidget {
  const PrimaryBtnIcon(
      {Key? key,
      required this.onClick,
      required this.title,
      required this.iconData})
      : super(key: key);

  final String title;
  final IconData iconData;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        iconData,
        color: AppConfig.TEXT_BTN_COLOR,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        backgroundColor:
            MaterialStateProperty.all<Color?>(AppConfig.MAIN_COLOR),
      ),
      onPressed: onClick,
      label: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppConfig.TEXT_BTN_COLOR,
        ),
      ),
    );
  }
}
