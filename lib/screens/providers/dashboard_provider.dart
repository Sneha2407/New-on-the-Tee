import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models.dart/dashboard_model.dart';

class DashboardProvider with ChangeNotifier {
  DashboardResponse? _dashboard;
  DashboardResponse? get dashboard => _dashboard;

  void setDashboard(DashboardResponse dashboard) {
    _dashboard = dashboard;
    notifyListeners();
  }

  bool _play = false;
  bool get isPlaying => _play;
  void setPlay(bool play) {
    _play = play;
    notifyListeners();
  }

  int playIndex = 0;
  int get getPlayIndex => playIndex;
  void setPlayIndex(int index) {
    playIndex = index;
    notifyListeners();
  }

  //dashboard method
  Future<void> fetchData(String accessToken, String isFav) async {
    const url =
        'https://www.nowonthetee.com/api/user/dashboard';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {'is_favourite': isFav},
    );

    final jsonResponse = json.decode(response.body);
    final dashboardResponse = DashboardResponse.fromJson(jsonResponse);
    if (dashboardResponse.code == 200) {
      print('Message: ${dashboardResponse.message}');
      print('Success: ${dashboardResponse.success}');
      print('Code: ${dashboardResponse.code}');
      print('Data: ${dashboardResponse.data}');
      setDashboard(dashboardResponse);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //get filter data
  Future<void> fetchFilterData(
      String accessToken, String email, String name, String hometown) async {
    const url = 'https://www.nowonthetee.com/api/search';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {'email': email, 'name': name, 'homeTown': hometown},
    );

    final jsonResponse = json.decode(response.body);
    final dashboardResponse = DashboardResponse.fromJson(jsonResponse);
    if (dashboardResponse.code == 200) {
      print('Message: ${dashboardResponse.message}');
      print('Success: ${dashboardResponse.success}');
      print('Code: ${dashboardResponse.code}');
      print('Data: ${dashboardResponse.data}');
      setDashboard(dashboardResponse);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //favourite method
  Future<void> updateFavourite(String accessToken, int id) async {
    const url = 'https://www.nowonthetee.com/api/favorite';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $accessToken'},
      body: {'id': id.toString()},
    );

    final jsonResponse = json.decode(response.body);
    final favResponse = FavResponse.fromJson(jsonResponse);
    if (favResponse.code == 200) {
      print('Message: ${favResponse.message}');
      print('Success: ${favResponse.success}');
      print('Code: ${favResponse.code}');
    } else {
      throw Exception('Failed to update Favourite!');
    }
  }

  Future<void> deleteAnnoucement(List<String> ids, String accessToken) async {
    // print(ids.toString());

    const url =
        'https://www.nowonthetee.com/api/delete-announcement';
    log(accessToken.toString());

    final response = await http.post(Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {"id": ids.toString()});

    final jsonResponse = json.decode(response.body);
    final delResponse = DeleteResponse.fromJson(jsonResponse);
    if (delResponse.code == 200) {
      print('Message: ${delResponse.message}');
      print('Success: ${delResponse.success}');
      print('Code: ${delResponse.code}');

      notifyListeners();
    } else {
      print('Message: ${delResponse.message}');
      print('Success: ${delResponse.success}');
      print('Code: ${delResponse.code}');

      throw Exception('Failed to delete annoucements!');
    }

    await fetchData(accessToken, "");
  }

  // throw Exception('Failed to delete annoucements!');
}
