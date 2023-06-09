import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/constants.dart';

class HomeScreen extends StatefulWidget {

  late bool isLogin;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 200,
              color: Colors.blueGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 200,
              color: Colors.blueGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 200,
              color: Colors.blueGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 200,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

}