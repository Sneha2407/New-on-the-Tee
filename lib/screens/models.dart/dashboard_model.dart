import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  String message;
  bool success;
  int code;
  List<Datum> data;

  DashboardResponse({
    required this.message,
    required this.success,
    required this.code,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        message: json["message"],
        success: json["success"],
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  String email;
  String url;
  String city;
  int favourite;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.url,
    required this.city,
    required this.favourite,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        url: json["url"],
        city: json["city"],
        favourite: json["favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "url": url,
        "city": city,
        "favourite": favourite,
      };
}

FavResponse favResponseFromJson(String str) =>
    FavResponse.fromJson(json.decode(str));

String favResponseToJson(FavResponse data) => json.encode(data.toJson());

class FavResponse {
  String message;
  bool success;
  int code;

  FavResponse({
    required this.message,
    required this.success,
    required this.code,
  });

  factory FavResponse.fromJson(Map<String, dynamic> json) => FavResponse(
        message: json["message"],
        success: json["success"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "code": code,
      };
}
