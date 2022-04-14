// To parse this JSON data, do
//
//     final contestTypeModel = contestTypeModelFromJson(jsonString);

import 'dart:convert';

ContestTypeModel contestTypeModelFromJson(String str) => ContestTypeModel.fromJson(json.decode(str));

String contestTypeModelToJson(ContestTypeModel data) => json.encode(data.toJson());

class ContestTypeModel {
  ContestTypeModel({
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
  String matchStatus;
  int matchTime;
  bool status;
  int code;
  String message;
  Response response;

  factory ContestTypeModel.fromJson(Map<String, dynamic> json) => ContestTypeModel(
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
    this.matchcontests,
    this.myjoinedTeams,
    this.myjoinedContest,
  });

  List<Matchcontest> matchcontests;
  List<MyjoinedTeam> myjoinedTeams;
  List<Contest> myjoinedContest;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    matchcontests: List<Matchcontest>.from(json["matchcontests"].map((x) => Matchcontest.fromJson(x))),
    myjoinedTeams: List<MyjoinedTeam>.from(json["myjoinedTeams"].map((x) => MyjoinedTeam.fromJson(x))),
    myjoinedContest: List<Contest>.from(json["myjoinedContest"].map((x) => Contest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "matchcontests": List<dynamic>.from(matchcontests.map((x) => x.toJson())),
    "myjoinedTeams": List<dynamic>.from(myjoinedTeams.map((x) => x.toJson())),
    "myjoinedContest": List<dynamic>.from(myjoinedContest.map((x) => x.toJson())),
  };
}

class Matchcontest {
  Matchcontest({
    this.contestTypeId,
    this.contestTitle,
    this.contestSubTitle,
    this.tncUrl,
    this.invUrl,
    this.contests,
  });

  int contestTypeId;
  String contestTitle;
  String contestSubTitle;
  dynamic tncUrl;
  dynamic invUrl;
  List<Contest> contests;

  factory Matchcontest.fromJson(Map<String, dynamic> json) => Matchcontest(
    contestTypeId: json["contest_type_id"],
    contestTitle: json["contestTitle"],
    contestSubTitle: json["contestSubTitle"],
    tncUrl: json["tnc_url"],
    invUrl: json["inv_url"],
    contests: List<Contest>.from(json["contests"].map((x) => Contest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contest_type_id": contestTypeId,
    "contestTitle": contestTitle,
    "contestSubTitle": contestSubTitle,
    "tnc_url": tncUrl,
    "inv_url": invUrl,
    "contests": List<dynamic>.from(contests.map((x) => x.toJson())),
  };
}

class Contest {
  Contest({
    this.contestTypeId,
    this.isCancelled,
    this.maxAllowedTeam,
    this.usableBonus,
    this.bonusContest,
    this.totalSpots,
    this.firstPrice,
    this.sortBy,
    this.totalWinningPrize,
    this.contestId,
    this.maxFees,
    this.entryFees,
    this.filledSpots,
    this.winnerPercentage,
    this.winnerCount,
    this.cancellation,
    this.contestTitle,
    this.contestSubTitle,
    this.maxEntries,
    this.joinedTeams,
  });

  int contestTypeId;
  bool isCancelled;
  int maxAllowedTeam;
  num usableBonus;
  bool bonusContest;
  int totalSpots;
  int firstPrice;
  int sortBy;
  int totalWinningPrize;
  int contestId;
  int maxFees;
  int entryFees;
  int filledSpots;
  int winnerPercentage;
  int winnerCount;
  bool cancellation;
  String contestTitle;
  String contestSubTitle;
  int maxEntries;
  List<JoinedTeam> joinedTeams;

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    contestTypeId: json["contest_type_id"] == null ? null : json["contest_type_id"],
    isCancelled: json["isCancelled"],
    maxAllowedTeam: json["maxAllowedTeam"],
    usableBonus: json["usable_bonus"],
    bonusContest: json["bonus_contest"],
    totalSpots: json["totalSpots"],
    firstPrice: json["firstPrice"],
    sortBy: json["sort_by"] == null ? null : json["sort_by"],
    totalWinningPrize: json["totalWinningPrize"],
    contestId: json["contestId"],
    maxFees: json["max_fees"] == null ? null : json["max_fees"],
    entryFees: json["entryFees"],
    filledSpots: json["filledSpots"],
    winnerPercentage: json["winnerPercentage"],
    winnerCount: json["winnerCount"],
    cancellation: json["cancellation"],
    contestTitle: json["contestTitle"] == null ? null : json["contestTitle"],
    contestSubTitle: json["contestSubTitle"] == null ? null : json["contestSubTitle"],
    maxEntries: json["maxEntries"] == null ? null : json["maxEntries"],
    joinedTeams: json["joinedTeams"] == null ? null : List<JoinedTeam>.from(json["joinedTeams"].map((x) => JoinedTeam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contest_type_id": contestTypeId == null ? null : contestTypeId,
    "isCancelled": isCancelled,
    "maxAllowedTeam": maxAllowedTeam,
    "usable_bonus": usableBonus,
    "bonus_contest": bonusContest,
    "totalSpots": totalSpots,
    "firstPrice": firstPrice,
    "sort_by": sortBy == null ? null : sortBy,
    "totalWinningPrize": totalWinningPrize,
    "contestId": contestId,
    "max_fees": maxFees == null ? null : maxFees,
    "entryFees": entryFees,
    "filledSpots": filledSpots,
    "winnerPercentage": winnerPercentage,
    "winnerCount": winnerCount,
    "cancellation": cancellation,
    "contestTitle": contestTitle == null ? null : contestTitle,
    "contestSubTitle": contestSubTitle == null ? null : contestSubTitle,
    "maxEntries": maxEntries == null ? null : maxEntries,
    "joinedTeams": joinedTeams == null ? null : List<dynamic>.from(joinedTeams.map((x) => x.toJson())),
  };
}

class JoinedTeam {
  JoinedTeam({
    this.teamName,
    this.createdTeamId,
    this.contestId,
    this.isWinning,
    this.rank,
    this.points,
    this.prizeAmount,
  });

  String teamName;
  int createdTeamId;
  int contestId;
  bool isWinning;
  int rank;
  int points;
  int prizeAmount;

  factory JoinedTeam.fromJson(Map<String, dynamic> json) => JoinedTeam(
    teamName: json["team_name"],
    createdTeamId: json["createdTeamId"],
    contestId: json["contestId"],
    isWinning: json["isWinning"],
    rank: json["rank"],
    points: json["points"],
    prizeAmount: json["prize_amount"],
  );

  Map<String, dynamic> toJson() => {
    "team_name": teamName,
    "createdTeamId": createdTeamId,
    "contestId": contestId,
    "isWinning": isWinning,
    "rank": rank,
    "points": points,
    "prize_amount": prizeAmount,
  };
}

class MyjoinedTeam {
  MyjoinedTeam({
    this.teamId,
  });

  int teamId;

  factory MyjoinedTeam.fromJson(Map<String, dynamic> json) => MyjoinedTeam(
    teamId: json["team_id"],
  );

  Map<String, dynamic> toJson() => {
    "team_id": teamId,
  };
}
