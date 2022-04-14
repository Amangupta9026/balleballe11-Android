// To parse this JSON data, do
//
//     final myContestModel = myContestModelFromJson(jsonString);

import 'dart:convert';

MyContestModel myContestModelFromJson(String str) =>
    MyContestModel.fromJson(json.decode(str));

String myContestModelToJson(MyContestModel data) => json.encode(data.toJson());

class MyContestModel {
  MyContestModel({
    this.systemTime,
    this.matchStatus,
    this.matchTime,
    this.status,
    this.code,
    this.message,
    this.response,
  });

  int systemTime;
  String matchStatus;
  int matchTime;
  bool status;
  int code;
  String message;
  Response response;

  factory MyContestModel.fromJson(Map<String, dynamic> json) => MyContestModel(
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
    this.myJoinedContest,
  });

  List<MyJoinedContest> myJoinedContest;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
      myJoinedContest: json != null
          ? List<MyJoinedContest>.from(
              json["my_joined_contest"].map((x) => MyJoinedContest.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() => {
        "my_joined_contest":
            List<dynamic>.from(myJoinedContest.map((x) => x.toJson())),
      };
}

class MyJoinedContest {
  MyJoinedContest({
    this.isCancelled,
    this.maxAllowedTeam,
    this.usableBonus,
    this.bonusContest,
    this.totalSpots,
    this.firstPrice,
    this.totalWinningPrize,
    this.contestTitle,
    this.contestSubTitle,
    this.contestId,
    this.entryFees,
    this.filledSpots,
    this.winnerPercentage,
    this.winnerCount,
    this.cancellation,
    this.maxEntries,
    this.joinedTeams,
  });

  bool isCancelled;
  int maxAllowedTeam;
  int usableBonus;
  bool bonusContest;
  int totalSpots;
  int firstPrice;
  int totalWinningPrize;
  String contestTitle;
  String contestSubTitle;
  int contestId;
  int entryFees;
  int filledSpots;
  int winnerPercentage;
  int winnerCount;
  bool cancellation;
  int maxEntries;
  List<JoinedTeam> joinedTeams;

  factory MyJoinedContest.fromJson(Map<String, dynamic> json) =>
      MyJoinedContest(
        isCancelled: json["isCancelled"],
        maxAllowedTeam: json["maxAllowedTeam"],
        usableBonus: json["usable_bonus"],
        bonusContest: json["bonus_contest"],
        totalSpots: json["totalSpots"],
        firstPrice: json["firstPrice"],
        totalWinningPrize: json["totalWinningPrize"],
        contestTitle: json["contestTitle"],
        contestSubTitle: json["contestSubTitle"],
        contestId: json["contestId"],
        entryFees: json["entryFees"],
        filledSpots: json["filledSpots"],
        winnerPercentage: json["winnerPercentage"],
        winnerCount: json["winnerCount"],
        cancellation: json["cancellation"],
        maxEntries: json["maxEntries"],
        joinedTeams: List<JoinedTeam>.from(
            json["joinedTeams"].map((x) => JoinedTeam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isCancelled": isCancelled,
        "maxAllowedTeam": maxAllowedTeam,
        "usable_bonus": usableBonus,
        "bonus_contest": bonusContest,
        "totalSpots": totalSpots,
        "firstPrice": firstPrice,
        "totalWinningPrize": totalWinningPrize,
        "contestTitle": contestTitle,
        "contestSubTitle": contestSubTitle,
        "contestId": contestId,
        "entryFees": entryFees,
        "filledSpots": filledSpots,
        "winnerPercentage": winnerPercentage,
        "winnerCount": winnerCount,
        "cancellation": cancellation,
        "maxEntries": maxEntries,
        "joinedTeams": List<dynamic>.from(joinedTeams.map((x) => x.toJson())),
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
  num points;
  num prizeAmount;

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
