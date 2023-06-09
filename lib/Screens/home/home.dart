import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/home/listdevice.dart';
import 'package:flutter_mobile_app/Screens/home/deviceitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Home"), backgroundColor: Color(0xFF0066B3)),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: dataforList.map((e) => DeviceItem(e.name)).toList(),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer();
  }
}

late final List<listofDevice> dataforList = [
  listofDevice(name: 'device1'),
  listofDevice(name: 'device2'),
  listofDevice(name: 'device3'),
  listofDevice(name: 'device4'),
];
