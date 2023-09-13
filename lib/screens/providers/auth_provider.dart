// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_on_the_tee/screens/home_page.dart';
import 'package:new_on_the_tee/screens/models.dart/login_model.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';
import '../models.dart/register_model.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  String _responseMessage = "";

  String? get message => _responseMessage;
  void setMessage(String message) {
    _responseMessage = message;
    notifyListeners();
  }

  String _accessToken = "";
  String? get accessToken => _accessToken;
  void setAccessToken(String accessToken) {
    _accessToken = accessToken;
    notifyListeners();
  }

  String loginResponseMessage = "";
  String? get loginMessage => loginResponseMessage;
  void setLoginMessage(String message) {
    loginResponseMessage = message;
    notifyListeners();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//register user method
  Future<void> postUser(String name, String email, String place, String city,
      BuildContext context) async {
    final url = 'https://www.nowonthetee.com/api/register';
    final body = {
      'name': name,
      'email': email,
      'place': place,
      'city': city,
    };

    final response = await http.post(Uri.parse(url), body: body);

    final jsonResponse = json.decode(response.body);
    final registerResponse = RegisterResponse.fromJson(jsonResponse);
    if (registerResponse.code == 200) {
      print('Message: ${registerResponse.message}');
      print('Success: ${registerResponse.success}');
      print('Code: ${registerResponse.code}');

      setMessage(registerResponse.message);
      showBottom(context, 4);
    } else if (registerResponse.code == 400) {
      // print('Request failed with status: ${response.statusCode}');
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          content: Text(
            'Error! ${registerResponse.message}',
            //  ${response.statusCode}! ${loginResponseMessage ?? ""}',
            style: mcLaren(Kcolors.white, 15),
          ),
        ),
      );
    } else {
      throw Exception('Failed to Register!');
    }

    notifyListeners();
  }

// login user method
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    const url = 'https://www.nowonthetee.com/api/login';

    final body = {
      'email': email,
      'password': password,
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Connection': 'keep-alive'
    };

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(body), // Encode the body as a JSON string
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    final loginResponse = LoginResponse.fromJson(jsonResponse);

    if (loginResponse.success == true) {
      print('Message: ${loginResponse.message}');
      print('Success: ${loginResponse.success}');
      print('Code: ${loginResponse.accessToken}');

      setLoginMessage(loginResponse.message ?? "");
      setAccessToken(loginResponse.accessToken ?? "");
      final SharedPreferences prefs = await _prefs;
      prefs.setString('accessToken', loginResponse.accessToken ?? "");

      // Push to the home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else if (loginResponse.success == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          content: Text(
            'Error ${loginResponse.message}',
            style: mcLaren(Kcolors.white, 15),
          ),
        ),
      );
    } else {
      throw Exception('Failed to Login!');
    }

    notifyListeners();
  }

  //change password
  Future<void> changePassword(String accessToken, String oldpassword,
      String newpassword, String confirmnew) async {
    const url =
        'https://www.nowonthetee.com/api/change-password';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {
        'oldPassword': oldpassword,
        'password': newpassword,
        'password_confirmation': confirmnew
      },
    );

    final jsonResponse = json.decode(response.body);
    final changeResponse = ChangePasswordResponse.fromJson(jsonResponse);
    if (changeResponse.code == 200) {
      print('Message: ${changeResponse.message}');
      print('Success: ${changeResponse.success}');
      print('Code: ${changeResponse.code}');
    } else {
      throw Exception(changeResponse.message);
    }
  }
}
