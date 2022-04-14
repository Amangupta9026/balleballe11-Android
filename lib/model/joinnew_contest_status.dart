import 'dart:convert';

JoinNewContestStatusModel joinNewContestStatusModelFromJson(String str) =>
    JoinNewContestStatusModel.fromJson(json.decode(str));

String joinNewContestStatusModelToJson(JoinNewContestStatusModel data) =>
    json.encode(data.toJson());

class JoinNewContestStatusModel {
  JoinNewContestStatusModel({
    this.status,
    this.code,
    this.message,
    this.action,
    this.teamList,
  });

  bool status;
  int code;
  String message;
  int action;
  dynamic teamList;

  factory JoinNewContestStatusModel.fromJson(Map<String, dynamic> json) =>
      JoinNewContestStatusModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        action: json["action"],
        teamList: json["team_list"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "action": action,
        "team_list": teamList,
      };
}
