import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/input_container.dart';
import 'package:flutter_mobile_app/constants.dart';

class RoundedDropdown extends StatelessWidget {
  const RoundedDropdown({
    Key? key,
    required this.icon,
    required this.hint,
    required this.dropdownValue,
    required this.dropdownItems,
    required this.onChanged,
    this.maxHeight,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final String dropdownValue;
  final List<String> dropdownItems;
  final void Function(String?) onChanged;
  final double? maxHeight;
  final double? iconSize;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight ?? double.infinity),
      child: InputContainer(
        child: Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
              size: iconSize,
            ),
            // SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: dropdownValue,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 7,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                ),
                items: dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
