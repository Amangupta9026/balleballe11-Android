class LoginModel {
  String pmid;
  String callUrl;
  String gPay;
  bool status;
  int isAccountVerified;
  int code;
  String message;
  Data data;
  String token;

  LoginModel(
      {this.pmid,
      this.callUrl,
      this.gPay,
      this.status,
      this.isAccountVerified,
      this.code,
      this.message,
      this.data,
      this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    pmid = json['pmid'];
    callUrl = json['call_url'];
    gPay = json['g_pay'];
    status = json['status'];
    isAccountVerified = json['is_account_verified'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pmid'] = this.pmid;
    data['call_url'] = this.callUrl;
    data['g_pay'] = this.gPay;
    data['status'] = this.status;
    data['is_account_verified'] = this.isAccountVerified;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String referalCode;
  String name;
  String email;
  String profileImage;
  String userId;
  String mobileNumber;
  bool otpverified;
  String teamName;
  String apkUrl;
  String pmid;
  String callUrl;
  String gPay;

  Data(
      {this.referalCode,
      this.name,
      this.email,
      this.profileImage,
      this.userId,
      this.mobileNumber,
      this.otpverified,
      this.teamName,
      this.apkUrl,
      this.pmid,
      this.callUrl,
      this.gPay});

  Data.fromJson(Map<String, dynamic> json) {
    referalCode = json['referal_code'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    userId = json['user_id'];
    mobileNumber = json['mobile_number'];
    otpverified = json['otpverified'];
    teamName = json['team_name'];
    apkUrl = json['apk_url'];
    pmid = json['pmid'];
    callUrl = json['call_url'];
    gPay = json['g_pay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referal_code'] = this.referalCode;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['user_id'] = this.userId;
    data['mobile_number'] = this.mobileNumber;
    data['otpverified'] = this.otpverified;
    data['team_name'] = this.teamName;
    data['apk_url'] = this.apkUrl;
    data['pmid'] = this.pmid;
    data['call_url'] = this.callUrl;
    data['g_pay'] = this.gPay;
    return data;
  }
}
