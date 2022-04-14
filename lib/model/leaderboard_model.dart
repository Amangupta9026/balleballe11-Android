// To parse this JSON data, do
//
//     final leaderboardModel = leaderboardModelFromJson(jsonString);

import 'dart:convert';

LeaderboardModel leaderboardModelFromJson(String str) =>
    LeaderboardModel.fromJson(json.decode(str));

String leaderboardModelToJson(LeaderboardModel data) =>
    json.encode(data.toJson());

class LeaderboardModel {
  LeaderboardModel({
    this.matchStatus,
    this.matchTime,
    this.status,
    this.code,
    this.message,
    this.totalTeam,
    this.leaderBoard,
  });

  dynamic matchStatus;
  dynamic matchTime;
  bool status;
  int code;
  String message;
  int totalTeam;
  List<LeaderBoard> leaderBoard;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardModel(
          matchStatus: json["match_status"],
          matchTime: json["match_time"],
          status: json["status"],
          code: json["code"],
          message: json["message"],
          totalTeam: json["total_team"],
          leaderBoard: json["leaderBoard"] != null
              ? List<LeaderBoard>.from(
                  json["leaderBoard"].map((x) => LeaderBoard.fromJson(x)))
              : []);

  Map<String, dynamic> toJson() => {
        "match_status": matchStatus,
        "match_time": matchTime,
        "status": status,
        "code": code,
        "message": message,
        "total_team": totalTeam,
        "leaderBoard": List<dynamic>.from(leaderBoard.map((x) => x.toJson())),
      };
}

class LeaderBoard {
  LeaderBoard({
    this.matchId,
    this.teamId,
    this.userId,
    this.team,
    this.point,
    this.rank,
    this.prizeAmount,
    this.winningAmount,
    this.user,
  });

  int matchId;
  int teamId;
  String userId;
  String team;
  num point;
  int rank;
  num prizeAmount;
  num winningAmount;
  User user;

  factory LeaderBoard.fromJson(Map<String, dynamic> json) => LeaderBoard(
        matchId: json["match_id"],
        teamId: json["team_id"],
        userId: json["user_id"],
        team: json["team"],
        point: json["point"],
        rank: json["rank"],
        prizeAmount: json["prize_amount"],
        winningAmount: json["winning_amount"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "team_id": teamId,
        "user_id": userId,
        "team": team,
        "point": point,
        "rank": rank,
        "prize_amount": prizeAmount,
        "winning_amount": winningAmount,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.name,
    this.userName,
    this.teamName,
    this.profileImage,
    this.shortName,
  });

  String firstName;
  String lastName;
  String name;
  String userName;
  String teamName;
  dynamic profileImage;
  int shortName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        name: json["name"],
        userName: json["user_name"],
        teamName: json["team_name"],
        profileImage: json["profile_image"],
        shortName: json["short_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "name": name,
        "user_name": userName,
        "team_name": teamName,
        "profile_image": profileImage,
        "short_name": shortName,
      };
}
