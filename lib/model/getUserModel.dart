// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  GetUserModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  Data data;

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.name,
    this.email,
    this.referalCode,
    this.profileImage,
    this.mobileNumber,
    this.city,
    this.gender,
    this.dateOfBirth,
    this.teamName,
    this.userName,
  });

  String userId;
  String name;
  String email;
  String referalCode;
  dynamic profileImage;
  String mobileNumber;
  String city;
  dynamic gender;
  String dateOfBirth;
  String teamName;
  String userName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        referalCode: json["referal_code"],
        profileImage: json["profile_image"],
        mobileNumber: json["mobile_number"],
        city: json["city"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        teamName: json["team_name"],
        userName: json["user_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "referal_code": referalCode,
        "profile_image": profileImage,
        "mobile_number": mobileNumber,
        "city": city,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "team_name": teamName,
        "user_name": userName,
      };
}
