import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/rounded_button.dart';
import 'package:flutter_mobile_app/components/rounded_input.dart';
import 'package:flutter_mobile_app/components/rounded_dropdown.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 5,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: 10),

                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),
                  ),

                  SizedBox(height: 5),

                  RoundedInput(icon: Icons.account_circle_rounded, hint: 'First Name'),

                  RoundedInput(icon: Icons.face_rounded, hint: 'Last Name'),

                  RoundedInput(icon: Icons.mail, hint: 'Email'),

                  RoundedInput(icon: Icons.call, hint: 'Phone'),

                  RoundedDropdown(
                    icon: Icons.place,
                    hint: 'Country',
                    dropdownValue: 'US',
                    dropdownItems: ['US', 'Germany', 'England', 'Iran'],
                    onChanged: (String? value) {
                      // TODO: Handle dropdown value change
                    },
                  ),

                  RoundedInput(icon: Icons.business, hint: 'Company'),

                  RoundedInput(icon: Icons.man, hint: 'Tenant Name'),

                  SizedBox(height: 20),

                  RoundedButton(title: 'SIGN UP'),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}