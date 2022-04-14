class CommonResponseModel {
  String message;
  bool success;

  CommonResponseModel({this.message, this.success});

  CommonResponseModel.fromJson(dynamic json) {
    message = json["message"];
    success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    map["success"] = success;
    return map;
  }
}
