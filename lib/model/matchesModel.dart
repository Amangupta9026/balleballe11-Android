// To parse this JSON data, do
//
//     final matchesModel = matchesModelFromJson(jsonString);

import 'dart:convert';

MatchesModel matchesModelFromJson(String str) =>
    MatchesModel.fromJson(json.decode(str));

String matchesModelToJson(MatchesModel data) => json.encode(data.toJson());

class MatchesModel {
  MatchesModel({
    this.maintainance,
    this.totalResult,
    this.promoter,
    this.status,
    this.code,
    this.message,
    this.systemTime,
    this.leadersboard,
    this.isLeadersboardActive,
    this.response1,
  });

  bool maintainance;
  int totalResult;
  int promoter;
  bool status;
  int code;
  String message;
  int systemTime;
  List<Leadersboard> leadersboard;
  int isLeadersboardActive;
  Response1 response1;

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
        maintainance: json["maintainance"],
        totalResult: json["total_result"],
        promoter: json["promoter"],
        status: json["status"],
        code: json["code"],
        message: json["message"],
        systemTime: json["system_time"],
        leadersboard: json["leadersboard"] != null
            ? List<Leadersboard>.from(
                json["leadersboard"].map((x) => Leadersboard.fromJson(x)))
            : [],
        isLeadersboardActive: json["isLeadersboardActive"],
        response1: Response1.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "maintainance": maintainance,
        "total_result": totalResult,
        "promoter": promoter,
        "status": status,
        "code": code,
        "message": message,
        "system_time": systemTime,
        "leadersboard": List<dynamic>.from(leadersboard.map((x) => x.toJson())),
        "isLeadersboardActive": isLeadersboardActive,
        "response1": response1.toJson(),
      };
}

class Leadersboard {
  Leadersboard({
    this.competitionId,
    this.title,
  });

  String competitionId;
  String title;

  factory Leadersboard.fromJson(Map<String, dynamic> json) => Leadersboard(
        competitionId: json["competition_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "competition_id": competitionId,
        "title": title,
      };
}

class Response1 {
  Response1({
    this.matchdata,
  });

  List<Matchdatum> matchdata;

  factory Response1.fromJson(Map<String, dynamic> json) => Response1(
          matchdata: List<Matchdatum>.from(
        json["matchdata"] != null
            ? json["matchdata"].map((x) => Matchdatum.fromJson(x))
            : [],
      ));

  Map<String, dynamic> toJson() => {
        "matchdata": List<dynamic>.from(matchdata.map((x) => x.toJson())),
      };
}

class Matchdatum {
  Matchdatum({
    this.viewType,
    this.joinedmatches,
    this.banners,
    this.upcomingmatches,
  });

  int viewType;
  List<Joinedmatch> joinedmatches;
  List<Banner> banners;
  List<Upcomingmatch> upcomingmatches;

  factory Matchdatum.fromJson(Map<String, dynamic> json) => Matchdatum(
        viewType: json["viewType"],
        joinedmatches: json["joinedmatches"] == null
            ? null
            : List<Joinedmatch>.from(
                json["joinedmatches"].map((x) => Joinedmatch.fromJson(x))),
        banners: json["banners"] == null
            ? null
            : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        upcomingmatches: json["upcomingmatches"] == null
            ? null
            : List<Upcomingmatch>.from(
                json["upcomingmatches"].map((x) => Upcomingmatch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "viewType": viewType,
        "joinedmatches": joinedmatches == null
            ? null
            : List<dynamic>.from(joinedmatches.map((x) => x.toJson())),
        "banners": banners == null
            ? null
            : List<dynamic>.from(banners.map((x) => x.toJson())),
        "upcomingmatches": upcomingmatches == null
            ? null
            : List<dynamic>.from(upcomingmatches.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    this.title,
    this.url,
    this.actiontype,
    this.description,
  });

  String title;
  String url;
  dynamic actiontype;
  String description;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        title: json["title"],
        url: json["url"],
        actiontype: json["actiontype"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "actiontype": actiontype,
        "description": description,
      };
}

class Joinedmatch {
  Joinedmatch({
    this.matchId,
    this.title,
    this.shortTitle,
    this.subtitle,
    this.status,
    this.statusStr,
    this.timestampStart,
    this.timestampEnd,
    this.gameState,
    this.gameStateStr,
    this.currentStatus,
    this.competitionId,
    this.formatStr,
    this.format,
    this.eventName,
    this.winningAmount,
    this.prizeAmount,
    this.leagueTitle,
    this.hasFreeContest,
    this.isLineup,
    this.totalJoinedTeam,
    this.totalJoinContests,
    this.teama,
    this.teamb,
  });

  int matchId;
  String title;
  String shortTitle;
  String subtitle;
  int status;
  String statusStr;
  int timestampStart;
  int timestampEnd;
  int gameState;
  String gameStateStr;
  int currentStatus;
  int competitionId;
  String formatStr;
  int format;
  String eventName;
  String winningAmount;
  String prizeAmount;
  String leagueTitle;
  bool hasFreeContest;
  bool isLineup;
  int totalJoinedTeam;
  int totalJoinContests;
  Team teama;
  Team teamb;

  factory Joinedmatch.fromJson(Map<String, dynamic> json) => Joinedmatch(
        matchId: json["match_id"],
        title: json["title"],
        shortTitle: json["short_title"],
        subtitle: json["subtitle"],
        status: json["status"],
        statusStr: json["status_str"],
        timestampStart: json["timestamp_start"],
        timestampEnd: json["timestamp_end"],
        gameState: json["game_state"],
        gameStateStr: json["game_state_str"],
        currentStatus: json["current_status"],
        competitionId: json["competition_id"],
        formatStr: json["format_str"],
        format: json["format"],
        eventName: json["event_name"] == null ? null : json["event_name"],
        winningAmount: json["winning_amount"],
        prizeAmount: json["prize_amount"],
        leagueTitle: json["league_title"],
        hasFreeContest: json["has_free_contest"],
        isLineup: json["is_lineup"],
        totalJoinedTeam: json["total_joined_team"],
        totalJoinContests: json["total_join_contests"],
        teama: Team.fromJson(json["teama"]),
        teamb: Team.fromJson(json["teamb"]),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "title": title,
        "short_title": shortTitle,
        "subtitle": subtitle,
        "status": status,
        "status_str": statusStr,
        "timestamp_start": timestampStart,
        "timestamp_end": timestampEnd,
        "game_state": gameState,
        "game_state_str": gameStateStr,
        "current_status": currentStatus,
        "competition_id": competitionId,
        "format_str": formatStr,
        "format": format,
        "event_name": eventName == null ? null : eventName,
        "winning_amount": winningAmount,
        "prize_amount": prizeAmount,
        "league_title": leagueTitle,
        "has_free_contest": hasFreeContest,
        "is_lineup": isLineup,
        "total_joined_team": totalJoinedTeam,
        "total_join_contests": totalJoinContests,
        "teama": teama.toJson(),
        "teamb": teamb.toJson(),
      };
}

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

class Upcomingmatch {
  Upcomingmatch({
    this.matchId,
    this.title,
    this.shortTitle,
    this.subtitle,
    this.status,
    this.statusStr,
    this.timestampStart,
    this.timestampEnd,
    this.dateStart,
    this.dateEnd,
    this.gameState,
    this.gameStateStr,
    this.statusNote,
    this.isFree,
    this.competitionId,
    this.formatStr,
    this.format,
    this.eventName,
    this.hasFreeContest,
    this.timeLeft,
    this.isLineup,
    this.leagueTitle,
    this.lastMatchPlayed,
    this.joinedSinglePlayer,
    this.singlePlayerAvailable,
    this.isMasterExist,
    this.isNormalExist,
    this.totalGuru,
    this.teama,
    this.teamb,
  });

  int matchId;
  String title;
  String shortTitle;
  String subtitle;
  int status;
  StatusStr statusStr;
  int timestampStart;
  int timestampEnd;
  String dateStart;
  DateTime dateEnd;
  int gameState;
  GameStateStr gameStateStr;
  String statusNote;
  int isFree;
  int competitionId;
  FormatStr formatStr;
  int format;
  dynamic eventName;
  bool hasFreeContest;
  String timeLeft;
  bool isLineup;
  String leagueTitle;
  String lastMatchPlayed;
  int joinedSinglePlayer;
  int singlePlayerAvailable;
  int isMasterExist;
  int isNormalExist;
  int totalGuru;
  Team teama;
  Team teamb;
  bool isTimeUp = false;

  factory Upcomingmatch.fromJson(Map<String, dynamic> json) => Upcomingmatch(
        matchId: json["match_id"],
        title: json["title"],
        shortTitle: json["short_title"],
        subtitle: json["subtitle"],
        status: json["status"],
        statusStr: statusStrValues.map[json["status_str"]],
        timestampStart: json["timestamp_start"],
        timestampEnd: json["timestamp_end"],
        dateStart: json["date_start"],
        dateEnd: DateTime.parse(json["date_end"]),
        gameState: json["game_state"],
        gameStateStr: gameStateStrValues.map[json["game_state_str"]],
        statusNote: json["status_note"],
        isFree: json["is_free"],
        competitionId: json["competition_id"],
        formatStr: formatStrValues.map[json["format_str"]],
        format: json["format"],
        eventName: json["event_name"],
        hasFreeContest: json["has_free_contest"],
        timeLeft: json["time_left"],
        isLineup: json["is_lineup"],
        leagueTitle: json["league_title"],
        lastMatchPlayed: json["last_match_played"],
        joinedSinglePlayer: json["joined_single_player"],
        singlePlayerAvailable: json["single_player_available"],
        isMasterExist: json["isMasterExist"],
        isNormalExist: json["isNormalExist"],
        totalGuru: json["total_guru"],
        teama: Team.fromJson(json["teama"]),
        teamb: Team.fromJson(json["teamb"]),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "title": title,
        "short_title": shortTitle,
        "subtitle": subtitle,
        "status": status,
        "status_str": statusStrValues.reverse[statusStr],
        "timestamp_start": timestampStart,
        "timestamp_end": timestampEnd,
        "date_start": dateStart,
        "date_end": dateEnd.toIso8601String(),
        "game_state": gameState,
        "game_state_str": gameStateStrValues.reverse[gameStateStr],
        "status_note": statusNote,
        "is_free": isFree,
        "competition_id": competitionId,
        "format_str": formatStrValues.reverse[formatStr],
        "format": format,
        "event_name": eventName,
        "has_free_contest": hasFreeContest,
        "time_left": timeLeft,
        "is_lineup": isLineup,
        "league_title": leagueTitle,
        "total_guru": totalGuru,
        "teama": teama.toJson(),
        "teamb": teamb.toJson(),
      };
}

enum FormatStr { T20, WOMAN_T20, ODI, TEST }

final formatStrValues = EnumValues({
  "ODI": FormatStr.ODI,
  "T20": FormatStr.T20,
  "Test": FormatStr.TEST,
  "Woman T20": FormatStr.WOMAN_T20
});

enum GameStateStr { DEFAULT }

final gameStateStrValues = EnumValues({"Default": GameStateStr.DEFAULT});

enum StatusStr { UPCOMING }

final statusStrValues = EnumValues({"Upcoming": StatusStr.UPCOMING});

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


// import 'dart:convert';

// MatchesModel matchesModelFromMap(String str) =>
//     MatchesModel.fromMap(json.decode(str));

// String matchesModelToMap(MatchesModel data) => json.encode(data.toMap());

// class MatchesModel {
//   MatchesModel({
//     this.maintainance,
//     this.totalResult,
//     this.promoter,
//     this.status,
//     this.code,
//     this.message,
//     this.systemTime,
//     this.leadersboard,
//     this.isLeadersboardActive,
//     this.response,
//   });

//   bool? maintainance;
//   int? totalResult;
//   int? promoter;
//   bool? status;
//   int? code;
//   String? message;
//   int? systemTime;
//   List<Leadersboard>? leadersboard;
//   int? isLeadersboardActive;
//   Response? response;

//   factory MatchesModel.fromMap(Map<String, dynamic> json) => MatchesModel(
//         maintainance: json["maintainance"],
//         totalResult: json["total_result"],
//         promoter: json["promoter"],
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//         systemTime: json["system_time"],
//         leadersboard: List<Leadersboard>.from(
//             json["leadersboard"].map((x) => Leadersboard.fromMap(x))),
//         isLeadersboardActive: json["isLeadersboardActive"],
//         response: Response.fromMap(json["response"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "maintainance": maintainance,
//         "total_result": totalResult,
//         "promoter": promoter,
//         "status": status,
//         "code": code,
//         "message": message,
//         "system_time": systemTime,
//         "leadersboard": List<dynamic>.from(leadersboard!.map((x) => x.toMap())),
//         "isLeadersboardActive": isLeadersboardActive,
//         "response": response!.toMap(),
//       };
// }

// class Leadersboard {
//   Leadersboard({
//     this.competitionId,
//     this.title,
//   });

//   String? competitionId;
//   String? title;

//   factory Leadersboard.fromMap(Map<String, dynamic> json) => Leadersboard(
//         competitionId: json["competition_id"],
//         title: json["title"],
//       );

//   Map<String, dynamic> toMap() => {
//         "competition_id": competitionId,
//         "title": title,
//       };
// }

// class Response {
//   Response({
//     this.matchdata,
//   });

//   List<Matchdatum>? matchdata;

//   factory Response.fromMap(Map<String, dynamic> json) => Response(
//         matchdata: List<Matchdatum>.from(
//             json["matchdata"].map((x) => Matchdatum.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "matchdata": List<dynamic>.from(matchdata!.map((x) => x.toMap())),
//       };
// }

// class Matchdatum {
//   Matchdatum({
//     this.viewType,
//     this.joinedmatches,
//     this.banners,
//     this.upcomingmatches,
//   });

//   int? viewType;
//   List<Joinedmatch>? joinedmatches;
//   List<Banner>? banners;
//   List<Upcomingmatch>? upcomingmatches;

//   factory Matchdatum.fromMap(Map<String, dynamic> json) => Matchdatum(
//         viewType: json["viewType"],
//         joinedmatches: json["joinedmatches"] == null
//             ? null
//             : List<Joinedmatch>.from(
//                 json["joinedmatches"].map((x) => Joinedmatch.fromMap(x))),
//         banners: json["banners"] == null
//             ? null
//             : List<Banner>.from(json["banners"].map((x) => Banner.fromMap(x))),
//         upcomingmatches: json["upcomingmatches"] == null
//             ? null
//             : List<Upcomingmatch>.from(
//                 json["upcomingmatches"].map((x) => Upcomingmatch.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "viewType": viewType,
//         "joinedmatches": joinedmatches == null
//             ? null
//             : List<dynamic>.from(joinedmatches!.map((x) => x.toMap())),
//         "banners": banners == null
//             ? null
//             : List<dynamic>.from(banners!.map((x) => x.toMap())),
//         "upcomingmatches": upcomingmatches == null
//             ? null
//             : List<dynamic>.from(upcomingmatches!.map((x) => x.toMap())),
//       };
// }

// class Banner {
//   Banner({
//     this.title,
//     this.url,
//     this.actiontype,
//     this.description,
//   });

//   String? title;
//   String? url;
//   dynamic actiontype;
//   String? description;

//   factory Banner.fromMap(Map<String, dynamic> json) => Banner(
//         title: json["title"],
//         url: json["url"],
//         actiontype: json["actiontype"],
//         description: json["description"],
//       );

//   Map<String, dynamic> toMap() => {
//         "title": title,
//         "url": url,
//         "actiontype": actiontype,
//         "description": description,
//       };
// }

// class Joinedmatch {
//   Joinedmatch({
//     this.matchId,
//     this.title,
//     this.shortTitle,
//     this.subtitle,
//     this.status,
//     this.statusStr,
//     this.timestampStart,
//     this.timestampEnd,
//     this.gameState,
//     this.gameStateStr,
//     this.currentStatus,
//     this.competitionId,
//     this.formatStr,
//     this.format,
//     this.eventName,
//     this.winningAmount,
//     this.prizeAmount,
//     this.leagueTitle,
//     this.hasFreeContest,
//     this.isLineup,
//     this.totalJoinedTeam,
//     this.totalJoinContests,
//     this.teama,
//     this.teamb,
//   });

//   int? matchId;
//   String? title;
//   String? shortTitle;
//   String? subtitle;
//   int? status;
//   String? statusStr;
//   int? timestampStart;
//   int? timestampEnd;
//   int? gameState;
//   String? gameStateStr;
//   int? currentStatus;
//   int? competitionId;
//   String? formatStr;
//   int? format;
//   String? eventName;
//   String? winningAmount;
//   String? prizeAmount;
//   String? leagueTitle;
//   bool? hasFreeContest;
//   bool? isLineup;
//   int? totalJoinedTeam;
//   int? totalJoinContests;
//   Team? teama;
//   Team? teamb;

//   factory Joinedmatch.fromMap(Map<String, dynamic> json) => Joinedmatch(
//         matchId: json["match_id"],
//         title: json["title"],
//         shortTitle: json["short_title"],
//         subtitle: json["subtitle"],
//         status: json["status"],
//         statusStr: json["status_str"],
//         timestampStart: json["timestamp_start"],
//         timestampEnd: json["timestamp_end"],
//         gameState: json["game_state"],
//         gameStateStr: json["game_state_str"],
//         currentStatus: json["current_status"],
//         competitionId: json["competition_id"],
//         formatStr: json["format_str"],
//         format: json["format"],
//         eventName: json["event_name"] == null ? null : json["event_name"],
//         winningAmount: json["winning_amount"],
//         prizeAmount: json["prize_amount"],
//         leagueTitle: json["league_title"],
//         hasFreeContest: json["has_free_contest"],
//         isLineup: json["is_lineup"],
//         totalJoinedTeam: json["total_joined_team"],
//         totalJoinContests: json["total_join_contests"],
//         teama: Team.fromMap(json["teama"]),
//         teamb: Team.fromMap(json["teamb"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "match_id": matchId,
//         "title": title,
//         "short_title": shortTitle,
//         "subtitle": subtitle,
//         "status": status,
//         "status_str": statusStr,
//         "timestamp_start": timestampStart,
//         "timestamp_end": timestampEnd,
//         "game_state": gameState,
//         "game_state_str": gameStateStr,
//         "current_status": currentStatus,
//         "competition_id": competitionId,
//         "format_str": formatStr,
//         "format": format,
//         "event_name": eventName == null ? null : eventName,
//         "winning_amount": winningAmount,
//         "prize_amount": prizeAmount,
//         "league_title": leagueTitle,
//         "has_free_contest": hasFreeContest,
//         "is_lineup": isLineup,
//         "total_joined_team": totalJoinedTeam,
//         "total_join_contests": totalJoinContests,
//         "teama": teama!.toMap(),
//         "teamb": teamb!.toMap(),
//       };
// }

// class Team {
//   Team({
//     this.matchId,
//     this.teamId,
//     this.name,
//     this.shortName,
//     this.logoUrl,
//     this.localImgUrl,
//     this.thumbUrl,
//     this.scoresFull,
//     this.scores,
//     this.overs,
//   });

//   int? matchId;
//   int? teamId;
//   String? name;
//   String? shortName;
//   String? logoUrl;
//   dynamic localImgUrl;
//   String? thumbUrl;
//   String? scoresFull;
//   String? scores;
//   String? overs;

//   factory Team.fromMap(Map<String, dynamic> json) => Team(
//         matchId: json["match_id"],
//         teamId: json["team_id"],
//         name: json["name"],
//         shortName: json["short_name"],
//         logoUrl: json["logo_url"],
//         localImgUrl: json["local_img_url"],
//         thumbUrl: json["thumb_url"] == null ? null : json["thumb_url"],
//         scoresFull: json["scores_full"],
//         scores: json["scores"],
//         overs: json["overs"],
//       );

//   Map<String, dynamic> toMap() => {
//         "match_id": matchId,
//         "team_id": teamId,
//         "name": name,
//         "short_name": shortName,
//         "logo_url": logoUrl,
//         "local_img_url": localImgUrl,
//         "thumb_url": thumbUrl == null ? null : thumbUrl,
//         "scores_full": scoresFull,
//         "scores": scores,
//         "overs": overs,
//       };
// }

// class Upcomingmatch {
//   Upcomingmatch({
//     this.matchId,
//     this.title,
//     this.shortTitle,
//     this.subtitle,
//     this.status,
//     this.statusStr,
//     this.timestampStart,
//     this.timestampEnd,
//     this.dateStart,
//     this.dateEnd,
//     this.gameState,
//     this.gameStateStr,
//     this.statusNote,
//     this.isFree,
//     this.competitionId,
//     this.formatStr,
//     this.format,
//     this.eventName,
//     this.hasFreeContest,
//     this.timeLeft,
//     this.isLineup,
//     this.leagueTitle,
//     this.totalGuru,
//     this.teama,
//     this.teamb,
//   });

//   int? matchId;
//   String? title;
//   String? shortTitle;
//   String? subtitle;
//   int? status;
//   StatusStr? statusStr;
//   int? timestampStart;
//   int? timestampEnd;
//   String? dateStart;
//   DateTime? dateEnd;
//   int? gameState;
//   GameStateStr? gameStateStr;
//   String? statusNote;
//   int? isFree;
//   int? competitionId;
//   FormatStr? formatStr;
//   int? format;
//   dynamic eventName;
//   bool? hasFreeContest;
//   String? timeLeft;
//   bool? isLineup;
//   String? leagueTitle;
//   int? totalGuru;
//   Team? teama;
//   Team? teamb;

//   factory Upcomingmatch.fromMap(Map<String, dynamic> json) => Upcomingmatch(
//         matchId: json["match_id"],
//         title: json["title"],
//         shortTitle: json["short_title"],
//         subtitle: json["subtitle"],
//         status: json["status"],
//         statusStr: statusStrValues.map![json["status_str"]],
//         timestampStart: json["timestamp_start"],
//         timestampEnd: json["timestamp_end"],
//         dateStart: json["date_start"],
//         dateEnd: DateTime.parse(json["date_end"]),
//         gameState: json["game_state"],
//         gameStateStr: gameStateStrValues.map![json["game_state_str"]],
//         statusNote: json["status_note"],
//         isFree: json["is_free"],
//         competitionId: json["competition_id"],
//         formatStr: formatStrValues.map![json["format_str"]],
//         format: json["format"],
//         eventName: json["event_name"],
//         hasFreeContest: json["has_free_contest"],
//         timeLeft: json["time_left"],
//         isLineup: json["is_lineup"],
//         leagueTitle: json["league_title"],
//         totalGuru: json["total_guru"],
//         teama: Team.fromMap(json["teama"]),
//         teamb: Team.fromMap(json["teamb"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "match_id": matchId,
//         "title": title,
//         "short_title": shortTitle,
//         "subtitle": subtitle,
//         "status": status,
//         "status_str": statusStrValues.reverse[statusStr],
//         "timestamp_start": timestampStart,
//         "timestamp_end": timestampEnd,
//         "date_start": dateStart,
//         "date_end": dateEnd!.toIso8601String(),
//         "game_state": gameState,
//         "game_state_str": gameStateStrValues.reverse[gameStateStr],
//         "status_note": statusNote,
//         "is_free": isFree,
//         "competition_id": competitionId,
//         "format_str": formatStrValues.reverse[formatStr],
//         "format": format,
//         "event_name": eventName,
//         "has_free_contest": hasFreeContest,
//         "time_left": timeLeft,
//         "is_lineup": isLineup,
//         "league_title": leagueTitle,
//         "total_guru": totalGuru,
//         "teama": teama!.toMap(),
//         "teamb": teamb!.toMap(),
//       };
// }

// enum FormatStr { T20, WOMAN_T20, ODI, TEST }

// final formatStrValues = EnumValues({
//   "ODI": FormatStr.ODI,
//   "T20": FormatStr.T20,
//   "Test": FormatStr.TEST,
//   "Woman T20": FormatStr.WOMAN_T20
// });

// enum GameStateStr { DEFAULT }

// final gameStateStrValues = EnumValues({"Default": GameStateStr.DEFAULT});

// enum StatusStr { UPCOMING }

// final statusStrValues = EnumValues({"Upcoming": StatusStr.UPCOMING});

// class EnumValues<T> {
//   Map<String, T> ?map;
//   Map<T, String> ?reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
