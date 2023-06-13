import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/input_container.dart';
import 'package:flutter_mobile_app/constants.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    this.textEditingController,
    required this.hint,
  }) : super(key: key);

  final String hint;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: textEditingController,
        cursorColor: kPrimaryColor,
        obscureText: true,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
  }
}