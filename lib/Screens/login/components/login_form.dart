import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/controller/LoginController.dart';
import 'package:flutter_mobile_app/components/rounded_button.dart';
import 'package:flutter_mobile_app/components/rounded_input.dart';
import 'package:flutter_mobile_app/components/rounded_password_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_mobile_app/Screens/home/home.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginController loginController = Get.put(LoginController());
  void navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 55),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),

                // const SizedBox(height: 10),

                Transform.scale(
                  scale: 0.8, // Tỷ lệ tăng lên 1.5 lần

                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(Color(0xFF0066B3),
                        BlendMode.srcIn), // Mã màu #000 (đen)
                    child: SvgPicture.asset(
                        'assets/images/ONE_IoT_logo_48x180.svg'),
                  ),
                ),

                const SizedBox(height: 20),

                 RoundedInput(
                  icon: Icons.mail,
                  hint: 'Email',
                  textEditingController: loginController.emailController,
                ),

                RoundedPasswordInput(textEditingController: loginController.passwordController, hint: 'Password'),

                const SizedBox(height: 10),

                GestureDetector(
                    onTap: () {
                      // navigateToHomePage(context);
                      // print('-----------------${loginController.passwordController.text}');
                      loginController.login(context);
                    },
                    child: const RoundedButton(title: 'LOGIN')),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
