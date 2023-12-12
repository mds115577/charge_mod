// To parse this JSON data, do
//
//     final userRegisterResponseModel = userRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

UserRegisterResponseModel userRegisterResponseModelFromJson(String str) =>
    UserRegisterResponseModel.fromJson(json.decode(str));

String userRegisterResponseModelToJson(UserRegisterResponseModel data) =>
    json.encode(data.toJson());

class UserRegisterResponseModel {
  String id;
  String mobile;
  String userType;
  bool isVerified;
  bool delFlag;
  String status;
  List<String> refreshToken;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String email;
  String firstName;
  String lastName;

  UserRegisterResponseModel({
    required this.id,
    required this.mobile,
    required this.userType,
    required this.isVerified,
    required this.delFlag,
    required this.status,
    required this.refreshToken,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterResponseModel(
        id: json["_id"],
        mobile: json["mobile"],
        userType: json["userType"],
        isVerified: json["isVerified"],
        delFlag: json["delFlag"],
        status: json["status"],
        refreshToken: List<String>.from(json["refreshToken"].map((x) => x)),
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mobile": mobile,
        "userType": userType,
        "isVerified": isVerified,
        "delFlag": delFlag,
        "status": status,
        "refreshToken": List<dynamic>.from(refreshToken.map((x) => x)),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}
