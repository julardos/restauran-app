import 'package:flutter/material.dart';
import 'package:restaurant/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
