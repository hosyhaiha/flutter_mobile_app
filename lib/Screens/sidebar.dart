import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/device/devicedata.dart';
import 'package:flutter_mobile_app/Screens/home/home.dart';
import 'package:flutter_mobile_app/Screens/login/login.dart';

class NavBar extends StatelessWidget {
  final bool isHomePage, isDevicePage;
  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToDevicePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeviceData()),
    );
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  // void navigateToHomePage(BuildContext context) {
  //   Navigator.pop(context); // Đóng thanh sidebar
  //   if (isHomePage) {
  //     print("This is " + isHomePage.toString());
  //     return; // Không cần tải lại trang
  //   }
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage()),
  //   );
  // }

  const NavBar(
      {super.key, required this.isHomePage, required this.isDevicePage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Something"),
            accountEmail: Text("email@mail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/anonymous.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/8562962_25552.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              if (isHomePage) {
                Navigator.pop(context); // Chỉ đóng thanh sidebar
              } else {
                navigateToHomePage(context); // Load lại trang Home
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.laptop),
            title: Text('Device'),
            onTap: () {
              if (isDevicePage) {
                Navigator.pop(context); // Chỉ đóng thanh sidebar
              } else {
                navigateToDevicePage(context); // Load lại trang Home
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () => navigateToLoginPage(context),
          )
        ],
      ),
    );
  }
}
