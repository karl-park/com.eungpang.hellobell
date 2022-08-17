import 'package:flutter/material.dart';
import 'package:hellobell/presentation/core/app_constant.dart';
import 'package:hellobell/presentation/core/app_theme.dart';
import 'package:hellobell/presentation/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      title: AppConstant.appName,
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: HomeScreen()
      )
    );
  }
}
