// To parse this JSON data, do
//
//     final playingHistoryModel = playingHistoryModelFromJson(jsonString);

import 'dart:convert';

PlayingHistoryModel playingHistoryModelFromJson(String str) =>
    PlayingHistoryModel.fromJson(json.decode(str));

String playingHistoryModelToJson(PlayingHistoryModel data) =>
    json.encode(data.toJson());

class PlayingHistoryModel {
  PlayingHistoryModel({
    this.status,
    this.code,
    this.message,
    this.response,
  });

  bool status;
  int code;
  String message;
  Response response;

  factory PlayingHistoryModel.fromJson(Map<String, dynamic> json) =>
      PlayingHistoryModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "response": response.toJson(),
      };
}

class Response {
  Response({
    this.userId,
    this.totalTeamJoined,
    this.totalMatchPlayed,
    this.totalContestJoined,
    this.totalUniqueContest,
    this.totalMatchWin,
    this.totalWinningAmount,
  });

  int userId;
  int totalTeamJoined;
  int totalMatchPlayed;
  int totalContestJoined;
  int totalUniqueContest;
  int totalMatchWin;
  num totalWinningAmount;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["user_id"],
        totalTeamJoined: json["total_team_joined"],
        totalMatchPlayed: json["total_match_played"],
        totalContestJoined: json["total_contest_joined"],
        totalUniqueContest: json["total_unique_contest"],
        totalMatchWin: json["total_match_win"],
        totalWinningAmount: json["total_winning_amount"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "total_team_joined": totalTeamJoined,
        "total_match_played": totalMatchPlayed,
        "total_contest_joined": totalContestJoined,
        "total_unique_contest": totalUniqueContest,
        "total_match_win": totalMatchWin,
        "total_winning_amount": totalWinningAmount,
      };
}
