import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/rounded_button.dart';
import 'package:flutter_mobile_app/components/rounded_input.dart';
import 'package:flutter_mobile_app/components/rounded_password_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
      opacity: isLogin ? 1.0 : 0.0,
      duration: animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const SizedBox(height: 55),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),

                // const SizedBox(height: 10),

                Transform.scale(
                  scale: 0.8, // Tỷ lệ tăng lên 1.5 lần

                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(Color(0xFF0066B3),
                        BlendMode.srcIn), // Mã màu #000 (đen)
                    child: SvgPicture.asset(
                        'assets/images/ONE_IoT_logo_48x180.svg'),
                  ),
                ),

                const SizedBox(height: 20),

                const RoundedInput(icon: Icons.mail, hint: 'Username'),

                const RoundedPasswordInput(hint: 'Password'),

                const SizedBox(height: 10),

                GestureDetector(
                    onTap:() => print('tap to login'),
                    child: const RoundedButton(title: 'LOGINN')),

                const SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
  }
}