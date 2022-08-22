import 'package:flutter/material.dart';
import 'package:hellobell/presentation/core/app_theme.dart';

import '../texts/app_texts.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.text, required this.onClick})
      : super(key: key);

  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     gradient: RadialGradient(
      //         colors: [AppTheme.surfaceColor, AppTheme.surfaceColor]),
      //     borderRadius: BorderRadius.circular(10.0)),
      child: TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: onClick,
          child: TextBody(text: text)),
    );
  }
}
