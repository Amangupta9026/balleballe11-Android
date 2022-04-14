// To parse this JSON data, do
//
//     final selectTeamJoinModel = selectTeamJoinModelFromJson(jsonString);

import 'dart:convert';

SelectTeamJoinModel selectTeamJoinModelFromJson(String str) =>
    SelectTeamJoinModel.fromJson(json.decode(str));

String selectTeamJoinModelToJson(SelectTeamJoinModel data) =>
    json.encode(data.toJson());

class SelectTeamJoinModel {
  SelectTeamJoinModel({
    this.sessionExpired,
    this.systemTime,
    this.matchStatus,
    this.matchTime,
    this.status,
    this.code,
    this.message,
    this.response,
  });

  bool sessionExpired;
  int systemTime;
  dynamic matchStatus;
  dynamic matchTime;
  bool status;
  int code;
  String message;
  Response response;

  factory SelectTeamJoinModel.fromJson(Map<String, dynamic> json) =>
      SelectTeamJoinModel(
        sessionExpired: json["session_expired"],
        systemTime: json["system_time"],
        matchStatus: json["match_status"],
        matchTime: json["match_time"],
        status: json["status"],
        code: json["code"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "session_expired": sessionExpired,
        "system_time": systemTime,
        "match_status": matchStatus,
        "match_time": matchTime,
        "status": status,
        "code": code,
        "message": message,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.joinedcontest,
  });

  List<Joinedcontest> joinedcontest;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        joinedcontest: List<Joinedcontest>.from(
            json["joinedcontest"].map((x) => Joinedcontest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "joinedcontest":
            List<dynamic>.from(joinedcontest.map((x) => x.toJson())),
      };
}

class Joinedcontest {
  Joinedcontest({
    this.matchId,
    this.userId,
    this.createdTeamId,
    this.contestId,
    this.teamCount,
    this.userName,
    this.teamName,
    this.entryfeeBonus,
    this.entryfeeDeposit,
    this.entryfeeWinning,
    this.entryfeeExtracash,
    this.premiumTeam,
  });

  String matchId;
  int userId;
  int createdTeamId;
  String contestId;
  String teamCount;
  String userName;
  String teamName;
  int entryfeeBonus;
  int entryfeeDeposit;
  int entryfeeWinning;
  int entryfeeExtracash;
  int premiumTeam;

  factory Joinedcontest.fromJson(Map<String, dynamic> json) => Joinedcontest(
        matchId: json["match_id"],
        userId: json["user_id"],
        createdTeamId: json["created_team_id"],
        contestId: json["contest_id"],
        teamCount: json["team_count"],
        userName: json["user_name"],
        teamName: json["team_name"],
        entryfeeBonus: json["entryfee_bonus"],
        entryfeeDeposit: json["entryfee_deposit"],
        entryfeeWinning: json["entryfee_winning"],
        entryfeeExtracash: json["entryfee_extracash"],
        premiumTeam: json["premium_team"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "user_id": userId,
        "created_team_id": createdTeamId,
        "contest_id": contestId,
        "team_count": teamCount,
        "user_name": userName,
        "team_name": teamName,
        "entryfee_bonus": entryfeeBonus,
        "entryfee_deposit": entryfeeDeposit,
        "entryfee_winning": entryfeeWinning,
        "entryfee_extracash": entryfeeExtracash,
        "premium_team": premiumTeam,
      };
}
