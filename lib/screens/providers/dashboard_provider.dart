import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/screens/providers/storage_provider.dart';
import 'package:provider/provider.dart';
import '../models.dart/dashboard_model.dart';

class DashboardProvider with ChangeNotifier {
  List? _dashboard = [];
  List? get dashboard => _dashboard;

  void setDashboard(List dashboard) {
    _dashboard = dashboard;
    notifyListeners();
  }

  //dashboard method
  Future<void> fetchData(String accessToken) async {
    const url =
        'https://fortmindz.co.in/nowOnTheTee_API/public/api/user/dashboard';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final dashboardResponse = DashboardResponse.fromJson(jsonResponse);
      print('Message: ${dashboardResponse.message}');
      print('Success: ${dashboardResponse.success}');
      print('Code: ${dashboardResponse.code}');
      print('Data: ${dashboardResponse.data}');
      setDashboard(dashboardResponse.data ?? []);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //favourite method
  Future<void> updateFavourite(String accessToken, int id) async {
    const url = 'https://fortmindz.co.in/nowOnTheTee_API/public/api/favorite';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final favResponse = FavResponse.fromJson(jsonResponse);
      print('Message: ${favResponse.message}');
      print('Success: ${favResponse.success}');
      print('Code: ${favResponse.code}');
    } else {
      throw Exception('Failed to update Favourite!');
    }
  }
}
