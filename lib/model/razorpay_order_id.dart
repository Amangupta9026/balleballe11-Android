// To parse this JSON data, do
//
//     final razorpayorderid = razorpayorderidFromJson(jsonString);

import 'dart:convert';

Razorpayorderid razorpayorderidFromJson(String str) =>
    Razorpayorderid.fromJson(json.decode(str));

String razorpayorderidToJson(Razorpayorderid data) =>
    json.encode(data.toJson());

class Razorpayorderid {
  Razorpayorderid({
    this.status,
    this.code,
    this.message,
    this.systemTime,
    this.orderId,
  });

  bool status;
  int code;
  String message;
  int systemTime;
  String orderId;

  factory Razorpayorderid.fromJson(Map<String, dynamic> json) =>
      Razorpayorderid(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        systemTime: json["system_time"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "system_time": systemTime,
        "order_id": orderId,
      };
}
