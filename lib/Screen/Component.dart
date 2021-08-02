import 'package:flutter/material.dart';

import 'package:hai_noob/App/Config.dart';

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
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Text(title),
        ),
      ],
    );
  }
}
