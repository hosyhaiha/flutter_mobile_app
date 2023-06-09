import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/constants.dart';

class DeviceItem extends StatelessWidget {
  final String name;
  DeviceItem(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        name,
        style: TextStyle(fontSize: 21),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kPrimaryColor.withOpacity(0.8), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
    );
  }
}
