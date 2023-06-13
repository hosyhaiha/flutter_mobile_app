import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/Screens/home/listdevice.dart';
import 'package:flutter_mobile_app/Screens/home/deviceitem.dart';
import 'package:flutter_mobile_app/Screens/sidebar.dart';
import 'package:flutter_mobile_app/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Color(0xFF0066B3),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => null, icon: Icon(Icons.notifications))
        ],
      ),
      // drawer: const NavigationDrawer(),
      body: FutureBuilder<List<Device>>(
        future: getListDevice(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data?.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return Text("${snapshot.data?[index].name}");
                });
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Text("Loading...");
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: GridView(
      //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //         maxCrossAxisExtent: 200,
      //         childAspectRatio: 3 / 2,
      //         crossAxisSpacing: 20,
      //         mainAxisSpacing: 20),
      //     children: getListDevice();
      //   ),
      // ),
    );
  }

  Future<List<Device>> getListDevice() async {
    final SharedPreferences? prefs = await _prefs;
    final String? token = prefs?.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(ApiEndpoints.getListDevice);
    http.Response response = await http.get(url, headers: headers);
    var json = jsonDecode(response.body);
    List<Device> listDevice = [];
    if (response.statusCode == 200) {
      for (var device in json) {
        listDevice.add(Device.fromJson(device));
      }
      return listDevice;
    } else {
      return listDevice;
    }
  }
}

// late final List<Device> dataforList = [
//   Device(name: 'device1'),
//   Device(name: 'device2'),
//   Device(name: 'device3'),
//   Device(name: 'device4'),
//   Device(name: 'device1'),
//   Device(name: 'device2'),
//   Device(name: 'device3'),
//   Device(name: 'device4'),
//   Device(name: 'device1'),
//   Device(name: 'device2'),
//   Device(name: 'device3'),
//   Device(name: 'device4'),
// ];
