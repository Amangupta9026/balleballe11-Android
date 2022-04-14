// To parse this JSON data, do
//
//     final profilePictureModel = profilePictureModelFromJson(jsonString);

import 'dart:convert';

ProfilePictureModel profilePictureModelFromJson(String str) =>
    ProfilePictureModel.fromJson(json.decode(str));

String profilePictureModelToJson(ProfilePictureModel data) =>
    json.encode(data.toJson());

class ProfilePictureModel {
  ProfilePictureModel({
    this.status,
    this.imageUrl,
    this.message,
  });

  bool status;
  String imageUrl;
  String message;

  factory ProfilePictureModel.fromJson(Map<String, dynamic> json) =>
      ProfilePictureModel(
        status: json["status"],
        imageUrl: json["image_url"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "image_url": imageUrl,
        "message": message,
      };
}
