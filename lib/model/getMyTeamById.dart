// To parse this JSON data, do
//
//     final getMyTeamByIdResponseModel = getMyTeamByIdResponseModelFromJson(jsonString);

import 'dart:convert';

GetMyTeamByIdResponseModel getMyTeamByIdResponseModelFromJson(String str) =>
    GetMyTeamByIdResponseModel.fromJson(json.decode(str));

String getMyTeamByIdResponseModelToJson(GetMyTeamByIdResponseModel data) =>
    json.encode(data.toJson());

class GetMyTeamByIdResponseModel {
  GetMyTeamByIdResponseModel({
    this.systemTime,
    this.matchStatus,
    this.matchTime,
    this.status,
    this.code,
    this.teamCount,
    this.message,
    this.response,
  });

  int systemTime;
  String matchStatus;
  int matchTime;
  bool status;
  int code;
  int teamCount;
  String message;
  Response response;

  factory GetMyTeamByIdResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMyTeamByIdResponseModel(
        systemTime: json["system_time"],
        matchStatus: json["match_status"],
        matchTime: json["match_time"],
        status: json["status"],
        code: json["code"],
        teamCount: json["teamCount"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "system_time": systemTime,
        "match_status": matchStatus,
        "match_time": matchTime,
        "status": status,
        "code": code,
        "teamCount": teamCount,
        "message": message,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.myteam,
  });

  List<TeamPlayersData> myteam;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        myteam: List<TeamPlayersData>.from(
            json["myteam"].map((x) => TeamPlayersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "myteam": List<dynamic>.from(myteam.map((x) => x.toJson())),
      };
}

class TeamPlayersData {
  TeamPlayersData({
    this.createdTeam,
    this.wk,
    this.bat,
    this.all,
    this.bowl,
    this.c,
    this.vc,
    this.match,
    this.team,
    this.cImg,
    this.vcImg,
    this.tImg,
    this.teamName,
    this.points,
    this.rank,
  });

  CreatedTeam createdTeam;
  List<int> wk;
  List<int> bat;
  List<int> all;
  List<int> bowl;
  C c;
  C vc;
  List<String> match;
  List<Team> team;
  String cImg;
  String vcImg;
  String tImg;
  String teamName;
  num points;
  int rank;

  int totalWk = 0,
      totalBatsMan = 0,
      totalBowlers = 0,
      totalAR = 0,
      totalPlayersOfTeamA = 0,
      totalPlayersOfTeamB = 0;
  String captainName = "", viceCaptainName = "";
  bool isTeamSelect = false;

  factory TeamPlayersData.fromJson(Map<String, dynamic> json) =>
      TeamPlayersData(
        createdTeam: CreatedTeam.fromJson(json["created_team"]),
        wk: List<int>.from(json["wk"].map((x) => x)),
        bat: List<int>.from(json["bat"].map((x) => x)),
        all: List<int>.from(json["all"].map((x) => x)),
        bowl: List<int>.from(json["bowl"].map((x) => x)),
        c: C.fromJson(json["c"]),
        vc: C.fromJson(json["vc"]),
        match: List<String>.from(json["match"].map((x) => x)),
        team: List<Team>.from(json["team"].map((x) => Team.fromJson(x))),
        cImg: json["c_img"],
        vcImg: json["vc_img"],
        tImg: json["t_img"],
        teamName: json["team_name"],
        points: json["points"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "created_team": createdTeam.toJson(),
        "wk": List<dynamic>.from(wk.map((x) => x)),
        "bat": List<dynamic>.from(bat.map((x) => x)),
        "all": List<dynamic>.from(all.map((x) => x)),
        "bowl": List<dynamic>.from(bowl.map((x) => x)),
        "c": c.toJson(),
        "vc": vc.toJson(),
        "match": List<dynamic>.from(match.map((x) => x)),
        "team": List<dynamic>.from(team.map((x) => x.toJson())),
        "c_img": cImg,
        "vc_img": vcImg,
        "t_img": tImg,
        "team_name": teamName,
        "points": points,
        "rank": rank,
      };
}

class C {
  C({
    this.pid,
    this.name,
  });

  int pid;
  String name;

  factory C.fromJson(Map<String, dynamic> json) => C(
        pid: json["pid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "name": name,
      };
}

class CreatedTeam {
  CreatedTeam({
    this.teamId,
  });

  int teamId;

  factory CreatedTeam.fromJson(Map<String, dynamic> json) => CreatedTeam(
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "team_id": teamId,
      };
}

class Team {
  Team({
    this.name,
    this.count,
  });

  String name;
  int count;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
