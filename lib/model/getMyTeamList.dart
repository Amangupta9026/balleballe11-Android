// To parse this JSON data, do
//
//     final getMyTeam = getMyTeamFromJson(jsonString);

import 'dart:convert';

GetMyTeam getMyTeamFromJson(String str) => GetMyTeam.fromJson(json.decode(str));

String getMyTeamToJson(GetMyTeam data) => json.encode(data.toJson());

class GetMyTeam {
  GetMyTeam({
    this.status,
    this.code,
    this.matchId,
    this.message,
    this.totalPoints,
    this.response,
  });

  bool status;
  int code;
  int matchId;
  String message;
  num totalPoints;
  Response response;

  factory GetMyTeam.fromJson(Map<String, dynamic> json) => GetMyTeam(
        status: json["status"],
        code: json["code"],
        matchId: json["match_id"],
        message: json["message"],
        totalPoints: json["total_points"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "match_id": matchId,
        "message": message,
        "total_points": totalPoints,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.playerPoints,
  });

  List<PlayerPoint> playerPoints;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        playerPoints: List<PlayerPoint>.from(
            json["player_points"].map((x) => PlayerPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "player_points":
            List<dynamic>.from(playerPoints.map((x) => x.toJson())),
      };
}

class PlayerPoint {
  PlayerPoint({
    this.pid,
    this.teamId,
    this.name,
    this.shortName,
    this.playerImage,
    this.points,
    this.fantasyPlayerRating,
    this.role,
    this.captain,
    this.viceCaptain,
    this.playing11,
  });

  String pid;
  int teamId;
  String name;
  String shortName;
  String playerImage;
  double points;
  double fantasyPlayerRating;
  String role;
  bool captain;
  bool viceCaptain;
  String playing11;

  factory PlayerPoint.fromJson(Map<String, dynamic> json) => PlayerPoint(
        pid: json["pid"],
        teamId: json["team_id"],
        name: json["name"],
        shortName: json["short_name"],
        playerImage: json["player_image"],
        points: json["points"].toDouble(),
        fantasyPlayerRating: json["fantasy_player_rating"].toDouble(),
        role: json["role"],
        captain: json["captain"],
        viceCaptain: json["vice_captain"],
        playing11: json["playing11"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "team_id": teamId,
        "name": name,
        "short_name": shortName,
        "player_image": playerImage,
        "points": points,
        "fantasy_player_rating": fantasyPlayerRating,
        "role": role,
        "captain": captain,
        "vice_captain": viceCaptain,
        "playing11": playing11,
      };
}
