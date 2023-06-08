import 'package:flutter/material.dart';
import 'package:demo3/Screens/login/login.dart';
import 'package:demo3/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animated Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: Typography.blackCupertino
      ),
      home: LoginScreen(),
    );
  }
}
