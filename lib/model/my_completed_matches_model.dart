// To parse this JSON data, do
//
//     final myCompletedMatchesModel = myCompletedMatchesModelFromJson(jsonString);

import 'dart:convert';

MyCompletedMatchesModel myCompletedMatchesModelFromJson(String str) =>
    MyCompletedMatchesModel.fromJson(json.decode(str));

String myCompletedMatchesModelToJson(MyCompletedMatchesModel data) =>
    json.encode(data.toJson());

class MyCompletedMatchesModel {
  MyCompletedMatchesModel({
    this.status,
    this.code,
    this.message,
    this.systemTime,
    this.response,
  });

  bool status;
  int code;
  String message;
  int systemTime;
  Response response;

  factory MyCompletedMatchesModel.fromJson(Map<String, dynamic> json) =>
      MyCompletedMatchesModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        systemTime: json["system_time"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "system_time": systemTime,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.matchdata,
  });

  List<Matchdatum> matchdata;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        matchdata: List<Matchdatum>.from(json["matchdata"] != null
            ? json["matchdata"].map((x) => Matchdatum.fromJson(x))
            : []),
      );

  Map<String, dynamic> toJson() => {
        "matchdata": List<dynamic>.from(matchdata.map((x) => x.toJson())),
      };
}

class Matchdatum {
  Matchdatum({
    this.actionType,
    this.completed,
  });

  String actionType;
  List<Completed> completed;

  factory Matchdatum.fromJson(Map<String, dynamic> json) => Matchdatum(
        actionType: json["action_type"],
        completed: List<Completed>.from(
            json["completed"].map((x) => Completed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "action_type": actionType,
        "completed": List<dynamic>.from(completed.map((x) => x.toJson())),
      };
}

class Completed {
  Completed({
    this.matchId,
    this.title,
    this.shortTitle,
    this.status,
    this.statusStr,
    this.timestampStart,
    this.timestampEnd,
    this.dateStart,
    this.dateEnd,
    this.gameState,
    this.gameStateStr,
    this.competitionId,
    this.currentStatus,
    this.leagueTitle,
    this.hasFreeContest,
    this.totalJoinedTeam,
    this.totalJoinContests,
    this.totalCreatedTeam,
    this.prizeAmount,
    this.teama,
    this.teamb,
  });

  int matchId;
  String title;
  String shortTitle;
  int status;
  String statusStr;
  int timestampStart;
  int timestampEnd;
  String dateStart;
  DateTime dateEnd;
  int gameState;
  GameStateStr gameStateStr;
  int competitionId;
  int currentStatus;
  dynamic leagueTitle;
  bool hasFreeContest;
  int totalJoinedTeam;
  int totalJoinContests;
  int totalCreatedTeam;
  num prizeAmount;
  Team teama;
  Team teamb;

  factory Completed.fromJson(Map<String, dynamic> json) => Completed(
        matchId: json["match_id"],
        title: json["title"],
        shortTitle: json["short_title"],
        status: json["status"],
        statusStr: json["status_str"],
        timestampStart: json["timestamp_start"],
        timestampEnd: json["timestamp_end"],
        dateStart: json["date_start"],
        dateEnd: DateTime.parse(json["date_end"]),
        gameState: json["game_state"],
        gameStateStr: gameStateStrValues.map[json["game_state_str"]],
        competitionId: json["competition_id"],
        currentStatus: json["current_status"],
        leagueTitle: json["league_title"],
        hasFreeContest: json["has_free_contest"],
        totalJoinedTeam: json["total_joined_team"],
        totalJoinContests: json["total_join_contests"],
        totalCreatedTeam: json["total_created_team"],
        prizeAmount: json["prize_amount"],
        teama: Team.fromJson(json["teama"]),
        teamb: Team.fromJson(json["teamb"]),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "title": title,
        "short_title": shortTitle,
        "status": status,
        "status_str": statusStrValues.reverse[statusStr],
        "timestamp_start": timestampStart,
        "timestamp_end": timestampEnd,
        "date_start": dateStart,
        "date_end": dateEnd.toIso8601String(),
        "game_state": gameState,
        "game_state_str": gameStateStrValues.reverse[gameStateStr],
        "competition_id": competitionId,
        "current_status": currentStatus,
        "league_title": leagueTitle,
        "has_free_contest": hasFreeContest,
        "total_joined_team": totalJoinedTeam,
        "total_join_contests": totalJoinContests,
        "total_created_team": totalCreatedTeam,
        "prize_amount": prizeAmount,
        "teama": teama.toJson(),
        "teamb": teamb.toJson(),
      };
}

enum GameStateStr { DEFAULT }

final gameStateStrValues = EnumValues({"Default": GameStateStr.DEFAULT});

enum StatusStr { ABANDONED, COMPLETED }

final statusStrValues = EnumValues(
    {"Abandoned": StatusStr.ABANDONED, "Completed": StatusStr.COMPLETED});

class Team {
  Team({
    this.matchId,
    this.teamId,
    this.name,
    this.shortName,
    this.logoUrl,
    this.localImgUrl,
    this.thumbUrl,
    this.scoresFull,
    this.scores,
    this.overs,
  });

  int matchId;
  int teamId;
  String name;
  String shortName;
  String logoUrl;
  dynamic localImgUrl;
  String thumbUrl;
  String scoresFull;
  String scores;
  String overs;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        matchId: json["match_id"],
        teamId: json["team_id"],
        name: json["name"],
        shortName: json["short_name"],
        logoUrl: json["logo_url"],
        localImgUrl: json["local_img_url"],
        thumbUrl: json["thumb_url"] == null ? null : json["thumb_url"],
        scoresFull: json["scores_full"],
        scores: json["scores"],
        overs: json["overs"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "team_id": teamId,
        "name": name,
        "short_name": shortName,
        "logo_url": logoUrl,
        "local_img_url": localImgUrl,
        "thumb_url": thumbUrl == null ? null : thumbUrl,
        "scores_full": scoresFull,
        "scores": scores,
        "overs": overs,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
