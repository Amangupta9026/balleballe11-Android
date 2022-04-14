// To parse this JSON data, do
//
//     final addMoneyModel = addMoneyModelFromJson(jsonString);

import 'dart:convert';

AddMoneyModel addMoneyModelFromJson(String str) =>
    AddMoneyModel.fromJson(json.decode(str));

String addMoneyModelToJson(AddMoneyModel data) => json.encode(data.toJson());

class AddMoneyModel {
  AddMoneyModel({
    this.status,
    this.code,
    this.message,
    this.walletInfo,
  });

  bool status;
  int code;
  String message;
  WalletInfo walletInfo;

  factory AddMoneyModel.fromJson(Map<String, dynamic> json) => AddMoneyModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        walletInfo: json["walletInfo"] != null ? WalletInfo.fromJson(json["walletInfo"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "walletInfo": walletInfo.toJson(),
      };
}

class WalletInfo {
  WalletInfo({
    this.walletAmount,
    this.userId,
  });

  double walletAmount;
  String userId;

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        walletAmount: json["wallet_amount"].toDouble(),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "wallet_amount": walletAmount,
        "user_id": userId,
      };
}
