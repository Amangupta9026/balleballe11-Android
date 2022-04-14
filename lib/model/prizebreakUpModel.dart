// To parse this JSON data, do
//
//     final prizeBreakUpModel = prizeBreakUpModelFromJson(jsonString);

import 'dart:convert';

PrizeBreakUpModel prizeBreakUpModelFromJson(String str) =>
    PrizeBreakUpModel.fromJson(json.decode(str));

String prizeBreakUpModelToJson(PrizeBreakUpModel data) =>
    json.encode(data.toJson());

class PrizeBreakUpModel {
  PrizeBreakUpModel({
    this.status,
    this.code,
    this.message,
    this.response,
  });

  bool status;
  int code;
  String message;
  Response response;

  factory PrizeBreakUpModel.fromJson(Map<String, dynamic> json) =>
      PrizeBreakUpModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.prizeBreakup,
  });

  List<PrizeBreakup> prizeBreakup;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        prizeBreakup: List<PrizeBreakup>.from(
            json["prizeBreakup"].map((x) => PrizeBreakup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "prizeBreakup": List<dynamic>.from(prizeBreakup.map((x) => x.toJson())),
      };
}

class PrizeBreakup {
  PrizeBreakup({
    this.range,
    this.price,
    this.betType,
    this.minTeam,
    this.additionalPrize,
  });

  String range;
  int price;
  dynamic betType;
  int minTeam;
  dynamic additionalPrize;

  factory PrizeBreakup.fromJson(Map<String, dynamic> json) => PrizeBreakup(
        range: json["range"],
        price: json["price"],
        betType: json["bet_type"],
        minTeam: json["min_team"],
        additionalPrize: json["additional_prize"],
      );

  Map<String, dynamic> toJson() => {
        "range": range,
        "price": price,
        "bet_type": betType,
        "min_team": minTeam,
        "additional_prize": additionalPrize,
      };
}
