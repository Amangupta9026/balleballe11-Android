// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.status,
    this.code,
    this.message,
  });

  bool status;
  int code;
  String message;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
