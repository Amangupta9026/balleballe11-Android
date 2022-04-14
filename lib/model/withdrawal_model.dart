// To parse this JSON data, do
//
//     final withDrawalModel = withDrawalModelFromJson(jsonString);

import 'dart:convert';

WithDrawalModel withDrawalModelFromJson(String str) =>
    WithDrawalModel.fromJson(json.decode(str));

String withDrawalModelToJson(WithDrawalModel data) =>
    json.encode(data.toJson());

class WithDrawalModel {
  WithDrawalModel({
    this.status,
    this.code,
    this.message,
  });

  bool status;
  int code;
  String message;

  factory WithDrawalModel.fromJson(Map<String, dynamic> json) =>
      WithDrawalModel(
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
