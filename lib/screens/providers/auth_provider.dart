import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_on_the_tee/screens/home_page.dart';
import 'package:new_on_the_tee/screens/models.dart/login_model.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:new_on_the_tee/widgets/bottomsheets.dart';

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

//register user method
  Future<void> postUser(String name, String email, String place, String city,
      BuildContext context) async {
    final url = 'https://fortmindz.co.in/nowOnTheTee_API/public/api/register';
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

      setMessage(registerResponse.message ?? "");
      showBottom(context, 4);
    } else if (registerResponse.code == 400) {
      // print('Request failed with status: ${response.statusCode}');
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error! ${registerResponse.message}',
            //  ${response.statusCode}! ${loginResponseMessage ?? ""}',
            style: mcLaren(Kcolors.white, 15),
          ),
        ),
      );
    }

    notifyListeners();
  }

// login user method
  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    const url = 'https://fortmindz.co.in/nowOnTheTee_API/public/api/login';

    final body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(Uri.parse(url), body: body);

    final jsonResponse = json.decode(response.body);
    final loginResponse = LoginResponse.fromJson(jsonResponse);
    if (loginResponse.success == true) {
      print('Message: ${loginResponse.message}');
      print('Success: ${loginResponse.success}');
      print('Code: ${loginResponse.accessToken}');

      setLoginMessage(loginResponse.message ?? "");
      setAccessToken(loginResponse.accessToken ?? "");
      //push to home page
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } else {
      final jsonResponseError = json.decode(response.body);
      final loginResponseErr = LoginErrorResponse.fromJson(jsonResponseError);
      print('Message: ${loginResponseErr.message}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error',
            //  ${response.statusCode}! ${loginResponseMessage ?? ""}',
            style: mcLaren(Kcolors.white, 15),
          ),
        ),
      );
    }

    notifyListeners();
  }

  // //register user method 2
  // Future<void> registerUser(
  //     String name, String email, String place, String city) async {
  //   final url = 'https://fortmindz.co.in/nowOnTheTee_API/public/api/register';

  //   final body = {
  //     'name': name,
  //     'email': email,
  //     'place': place,
  //     'city': city,
  //   };

  //   final response = await http.post(Uri.parse(url), body: body);

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     final registerResponse = RegisterResponse.fromJson(jsonResponse);
  //     // setState(() {
  //     //   message = registerResponse.message;
  //     // });
  //     // _responseMessage = registerResponse.message;
  //     setMessage(registerResponse.message ?? "");
  //     print('Message: ${registerResponse.message}');
  //     print('Success: ${registerResponse.success}');
  //     print('Code: ${registerResponse.code}');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }
}
