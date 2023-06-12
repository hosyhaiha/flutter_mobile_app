import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/login/login.dart';

class NavBar extends StatelessWidget {
  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  const NavBar({super.key});

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
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.laptop),
            title: Text('Device'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
            onTap: () => null,
          ),
          Divider(),
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
