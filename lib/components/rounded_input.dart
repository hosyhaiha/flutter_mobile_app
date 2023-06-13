import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/input_container.dart';
import 'package:flutter_mobile_app/constants.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    this.textEditingController,
    required this.icon,
    required this.hint
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: textEditingController,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
  }
}