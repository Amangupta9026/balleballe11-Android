// To parse this JSON data, do
//
//     final addMoneyResponseModel = addMoneyResponseModelFromJson(jsonString);

import 'dart:convert';

AddMoneyResponseModel addMoneyResponseModelFromJson(String str) =>
    AddMoneyResponseModel.fromJson(json.decode(str));

String addMoneyResponseModelToJson(AddMoneyResponseModel data) =>
    json.encode(data.toJson());

class AddMoneyResponseModel {
  AddMoneyResponseModel({
    this.status,
    this.code,
    this.message,
  });

  bool status;
  int code;
  String message;

  factory AddMoneyResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMoneyResponseModel(
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
