import 'package:flutter/material.dart';
import 'package:hellobell/presentation/core/app_theme.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 32
      ),
    );
  }
}

class TextBody extends StatelessWidget {
  const TextBody({
    Key? key,
    required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 18
      ),
    );
  }
}