import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String message;
  bool success;
  int code;
  String accessToken;
  String tokenType;
  int expiresIn;

  LoginResponse({
    required this.message,
    required this.success,
    required this.code,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        success: json["success"],
        code: json["code"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "code": code,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}

LoginErrorResponse loginErrorResponseFromJson(String str) =>
    LoginErrorResponse.fromJson(json.decode(str));

String loginErrorResponseToJson(LoginErrorResponse data) =>
    json.encode(data.toJson());

class LoginErrorResponse {
  String message;
  bool success;
  int code;

  LoginErrorResponse({
    required this.message,
    required this.success,
    required this.code,
  });

  factory LoginErrorResponse.fromJson(Map<String, dynamic> json) =>
      LoginErrorResponse(
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
