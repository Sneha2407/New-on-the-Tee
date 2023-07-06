import 'package:flutter/material.dart';

class StorageProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";
  String _name = "";
  String _city = "";
  String _intro = "";

  String? get email => _email;
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String? get password => _password;
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String? get name => _name;
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  String? get city => _city;
  void setCity(String city) {
    _city = city;
    notifyListeners();
  }

  String? get intro => _intro;
  void setIntro(String intro) {
    _intro = intro;
    notifyListeners();
  }
}
