import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../home/home.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<void> login(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndpoints.getToken);
      Map body = {
        'account': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'rememberMe': true
      };
      // Map body = {"account":"tech124@yopmail.com","password":"123456aA@","rememberMe":true};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['id_token']!=null || json['id_token']!= "") {
          var token = json['id_token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          emailController.clear();
          passwordController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
