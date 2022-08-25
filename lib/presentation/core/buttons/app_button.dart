import 'package:flutter/material.dart';

import '../texts/app_texts.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: onClick,
          child: TextBody(text: text)),
    );
  }
}
