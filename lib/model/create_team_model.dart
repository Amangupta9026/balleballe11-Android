// To parse this JSON data, do
//
//     final createTeamModel = createTeamModelFromJson(jsonString);

import 'dart:convert';

CreateTeamModel createTeamModelFromJson(String str) =>
    CreateTeamModel.fromJson(json.decode(str));

String createTeamModelToJson(CreateTeamModel data) =>
    json.encode(data.toJson());

class CreateTeamModel {
  CreateTeamModel({
    this.systemTime,
    this.matchStatus,
    this.matchTime,
    this.status,
    this.code,
    this.message,
    this.response,
  });

  int systemTime;
  dynamic matchStatus;
  dynamic matchTime;
  bool status;
  int code;
  String message;
  Response response;

  factory CreateTeamModel.fromJson(Map<String, dynamic> json) =>
      CreateTeamModel(
        systemTime: json["system_time"],
        matchStatus: json["match_status"],
        matchTime: json["match_time"],
        status: json["status"],
        code: json["code"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
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
    this.matchconteam,
  });

  Matchconteam matchconteam;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        matchconteam: Matchconteam.fromJson(json["matchconteam"]),
      );

  Map<String, dynamic> toJson() => {
        "matchconteam": matchconteam.toJson(),
      };
}

class Matchconteam {
  Matchconteam({
    this.teamCount,
    this.expertTeamId,
    this.expertUserId,
    this.matchId,
    this.contestId,
    this.teamId,
    this.teams,
    this.captain,
    this.viceCaptain,
    this.userId,
    this.createTeamId,
  });

  String teamCount;
  dynamic expertTeamId;
  dynamic expertUserId;
  int matchId;
  dynamic contestId;
  List<int> teamId;
  String teams;
  int captain;
  int viceCaptain;
  int userId;
  int createTeamId;

  factory Matchconteam.fromJson(Map<String, dynamic> json) => Matchconteam(
        teamCount: json["team_count"],
        expertTeamId: json["expert_team_id"],
        expertUserId: json["expert_user_id"],
        matchId: json["match_id"],
        contestId: json["contest_id"],
        teamId: List<int>.from(json["team_id"].map((x) => x)),
        teams: json["teams"],
        captain: json["captain"],
        viceCaptain: json["vice_captain"],
        userId: json["user_id"],
        createTeamId: json["create_team_id"],
      );

  Map<String, dynamic> toJson() => {
        "team_count": teamCount,
        "expert_team_id": expertTeamId,
        "expert_user_id": expertUserId,
        "match_id": matchId,
        "contest_id": contestId,
        "team_id": List<dynamic>.from(teamId.map((x) => x)),
        "teams": teams,
        "captain": captain,
        "vice_captain": viceCaptain,
        "user_id": userId,
        "create_team_id": createTeamId,
      };
}
