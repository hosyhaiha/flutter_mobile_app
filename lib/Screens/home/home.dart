import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/device/devicedata.dart';
import 'package:flutter_mobile_app/Screens/home/deviceitem.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToDevicePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeviceData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        isHomePage: true,
        isDevicePage: false,
      ),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.notifications))
        ],
      ),
      // drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: dataforList.map((e) {
            return GestureDetector(
              onTap: () {
                // Xử lý sự kiện khi thành phần được nhấn
                print('Tapped item: ${e.name}');
                navigateToDevicePage(context);
              },
              child: DeviceItem(e.name),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class listofDevice {
  final String name;

  listofDevice({required this.name});
}

late final List<listofDevice> dataforList = [
  listofDevice(name: 'device1'),
  listofDevice(name: 'device2'),
  listofDevice(name: 'device3'),
  listofDevice(name: 'device4'),
  listofDevice(name: 'device1'),
  listofDevice(name: 'device2'),
  listofDevice(name: 'device3'),
  listofDevice(name: 'device4'),
  listofDevice(name: 'device1'),
  listofDevice(name: 'device2'),
  listofDevice(name: 'device3'),
  listofDevice(name: 'device4'),
];

// bool isHomePage = true;
// void setHomePageState(bool value) {
//   isHomePage = value;
// }
