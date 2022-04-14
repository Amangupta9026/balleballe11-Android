// To parse this JSON data, do
//
//     final squadPlayersModel = squadPlayersModelFromJson(jsonString);

import 'dart:convert';

SquadPlayersModel squadPlayersModelFromJson(String str) =>
    SquadPlayersModel.fromJson(json.decode(str));

String squadPlayersModelToJson(SquadPlayersModel data) =>
    json.encode(data.toJson());

class SquadPlayersModel {
  SquadPlayersModel({
    this.systemTime,
    this.status,
    this.code,
    this.message,
    this.response,
  });

  int systemTime;
  bool status;
  int code;
  String message;
  Response response;

  factory SquadPlayersModel.fromJson(Map<String, dynamic> json) =>
      SquadPlayersModel(
        systemTime: json["system_time"],
        status: json["status"],
        code: json["code"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "system_time": systemTime,
        "status": status,
        "code": code,
        "message": message,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.players,
  });

  Players players;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        players: Players.fromJson(json["players"]),
      );

  Map<String, dynamic> toJson() => {
        "players": players.toJson(),
      };
}

class Players {
  Players({
    this.wk,
    this.bat,
    this.all,
    this.bowl,
  });

  List<CricketPlayerModel> wk;
  List<CricketPlayerModel> bat;
  List<CricketPlayerModel> all;
  List<CricketPlayerModel> bowl;

  factory Players.fromJson(Map<String, dynamic> json) => Players(
        wk: List<CricketPlayerModel>.from(
            json["wk"].map((x) => CricketPlayerModel.fromJson(x))),
        bat: List<CricketPlayerModel>.from(
            json["bat"].map((x) => CricketPlayerModel.fromJson(x))),
        all: List<CricketPlayerModel>.from(
            json["all"].map((x) => CricketPlayerModel.fromJson(x))),
        bowl: List<CricketPlayerModel>.from(
            json["bowl"].map((x) => CricketPlayerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wk": List<dynamic>.from(wk.map((x) => x.toJson())),
        "bat": List<dynamic>.from(bat.map((x) => x.toJson())),
        "all": List<dynamic>.from(all.map((x) => x.toJson())),
        "bowl": List<dynamic>.from(bowl.map((x) => x.toJson())),
      };
}

class CricketPlayerModel {
  CricketPlayerModel({
    this.viceCaptainPercentage,
    this.captainPercentage,
    this.playingRole,
    this.playerPoints,
    this.playing11,
    this.teamName,
    this.pid,
    this.matchId,
    this.teamId,
    this.playerImage,
    this.points,
    this.shortName,
    this.fullName,
    this.birthDate,
    this.nationality,
    this.battingStyle,
    this.bowlingStyle,
    this.fantasyPlayerRating,
    this.analytics,
  });
  bool isSelected = false;
  bool isCaptainSelected = false;
  bool isViceCaptainSelected = false;
  double viceCaptainPercentage;
  double captainPercentage;
  String playingRole;
  int playerPoints;
  bool playing11;
  TeamName teamName;
  int pid;
  int matchId;
  int teamId;
  String playerImage;
  String points;
  String shortName;
  String fullName;
  dynamic birthDate;
  Nationality nationality;
  BattingStyle battingStyle;
  BowlingStyle bowlingStyle;
  String fantasyPlayerRating;
  Analytics analytics;

  factory CricketPlayerModel.fromJson(Map<String, dynamic> json) =>
      CricketPlayerModel(
        playerPoints: json["playerPoints"],
        playing11: json["playing11"],
        teamName: teamNameValues.map[json["team_name"]],
        pid: json["pid"],
        matchId: json["match_id"],
        teamId: json["team_id"],
        playerImage: json["player_image"],
        points: json["points"],
        shortName: json["short_name"],
        fullName: json["full_name"],
        birthDate: json["birth_date"],
        nationality: json["nationality"] == null
            ? null
            : nationalityValues.map[json["nationality"]],
        battingStyle: battingStyleValues.map[json["batting_style"]],
        bowlingStyle: bowlingStyleValues.map[json["bowling_style"]],
        fantasyPlayerRating: json["fantasy_player_rating"],
        analytics: Analytics.fromJson(json["analytics"]),
      );

  Map<String, dynamic> toJson() => {
        "playerPoints": playerPoints,
        "playing11": playing11,
        "team_name": teamNameValues.reverse[teamName],
        "pid": pid,
        "match_id": matchId,
        "team_id": teamId,
        "player_image": playerImage,
        "points": points,
        "short_name": shortName,
        "full_name": fullName,
        "birth_date": birthDate,
        "nationality":
            nationality == null ? null : nationalityValues.reverse[nationality],
        "batting_style": battingStyleValues.reverse[battingStyle],
        "bowling_style": bowlingStyleValues.reverse[bowlingStyle],
        "fantasy_player_rating": fantasyPlayerRating,
        "analytics": analytics.toJson(),
      };
}

class Analytics {
  Analytics({
    this.selection,
    this.viceCaptain,
    this.captain,
  });

  String selection;
  double viceCaptain;
  double captain;

  factory Analytics.fromJson(Map<String, dynamic> json) {
    double vice_captain = double.tryParse("${json["vice_captain"]}") ?? 0.0;
    double captain = double.tryParse("${json["captain"]}") ?? 0.0;

    return Analytics(
        selection: json["selection"],
        viceCaptain: vice_captain,
        captain: captain);
  }

  Map<String, dynamic> toJson() => {
        "selection": selection,
        "vice_captain": viceCaptain,
        "captain": captain,
      };
}

enum BattingStyle { LEFT_HAND_BAT, RIGHT_HAND_BAT, EMPTY }

final battingStyleValues = EnumValues({
  "": BattingStyle.EMPTY,
  "Left hand Bat": BattingStyle.LEFT_HAND_BAT,
  "Right Hand Bat": BattingStyle.RIGHT_HAND_BAT
});

enum BirthDateEnum { THE_00000000 }

final birthDateEnumValues =
    EnumValues({"0000-00-00": BirthDateEnum.THE_00000000});

enum BowlingStyle {
  LEFT_ARM_ORTHODOX,
  RIGHT_ARM_MEDIUM,
  RIGHT_ARM_MEDIUM_FAST,
  EMPTY,
  RIGHT_ARM_OFF_BREAK
}

final bowlingStyleValues = EnumValues({
  "": BowlingStyle.EMPTY,
  "Left Arm Orthodox": BowlingStyle.LEFT_ARM_ORTHODOX,
  "Right Arm Medium": BowlingStyle.RIGHT_ARM_MEDIUM,
  "Right Arm Medium Fast": BowlingStyle.RIGHT_ARM_MEDIUM_FAST,
  "Right Arm Off Break": BowlingStyle.RIGHT_ARM_OFF_BREAK
});

enum Nationality { OMAN, INDIA }

final nationalityValues =
    EnumValues({"India": Nationality.INDIA, "Oman": Nationality.OMAN});

enum TeamName { BB, AR }

final teamNameValues = EnumValues({"AR": TeamName.AR, "BB": TeamName.BB});

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
