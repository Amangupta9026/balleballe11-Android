// To parse this JSON data, do
//
//     final checkSumModel = checkSumModelFromJson(jsonString);

import 'dart:convert';

CheckSumModel checkSumModelFromJson(String str) =>
    CheckSumModel.fromJson(json.decode(str));

String checkSumModelToJson(CheckSumModel data) => json.encode(data.toJson());

class CheckSumModel {
  CheckSumModel({
    this.checksumhash,
    this.orderId,
    this.status,
  });

  String checksumhash;
  String orderId;
  String status;

  factory CheckSumModel.fromJson(Map<String, dynamic> json) => CheckSumModel(
        checksumhash: json["CHECKSUMHASH"],
        orderId: json["order_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "CHECKSUMHASH": checksumhash,
        "order_id": orderId,
        "status": status,
      };
}
