import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:balleballe11/constance/apiConstants.dart';
import 'package:balleballe11/model/add_money_model.dart';
import 'package:balleballe11/model/checksum.Model.dart';
import 'package:balleballe11/model/commonResponseModel.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/create_team_model.dart';
import 'package:balleballe11/model/deviceInfoModel.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/get_mywallet_model.dart';
import 'package:balleballe11/model/joinnew_contest_status.dart';
import 'package:balleballe11/model/leaderboard_model.dart';
import 'package:balleballe11/model/login_model.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/my_contest_model.dart';
import 'package:balleballe11/model/my_joined_upcomingmatches.dart';
import 'package:balleballe11/model/myjoined_live_matches_model.dart';
import 'package:balleballe11/model/playing_history_model.dart';
import 'package:balleballe11/model/prizebreakUpModel.dart';
import 'package:balleballe11/model/razorpay_order_id.dart';
import 'package:balleballe11/model/select_team_join_model.dart';
import 'package:balleballe11/model/selected_team_model.dart';
import 'package:balleballe11/model/squad_players_model.dart';
import 'package:balleballe11/model/transaction_history_model.dart';
import 'package:balleballe11/sharedPreference/sharedPreference.dart';
import 'package:balleballe11/sports/My%20Accounts/playing_history.dart';
import 'package:balleballe11/widget/appException.dart';
import 'package:balleballe11/widget/utils.dart';

import '../model/getUserModel.dart';
import '../model/profilepicture_model.dart';
import '../model/updateProfile_model.dart';
import '../model/withdrawal_model.dart';
import 'dioClient.dart';

class APIServices {
  static Future<LoginModel> getLoginApi(String userEmail, String password,
      String loginType, String profilePic, String Name) async {
    //DeviceInfoModel deviceInfoModel = await Utils.getDeviceInfo();
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "deviceDetails": _commonDevice,
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": userEmail,
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": Name,
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "hFb0hdbcItQrK2H4MT2QluSu8cn2",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": "",
        "user_type": loginType,
        "username": userEmail,
        "version_code": 0,
        "withdraw_amount": 0
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_LOGIN, data: _body);

      log("data print ${_body}");

      CommonResponseModel commonResponseModel =
          CommonResponseModel.fromJson(response.data);
      log("Response Data ${json.encode(response.data)}");

      //   log('Response Data message ${response.data}');
      if (response.statusCode == 200) {
        log("Response Data ${json.encode(response.data)}");

        return LoginModel.fromJson(response.data);
      } else {
        throw new AppException(commonResponseModel.message);
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // Registeration API

  static Future<LoginModel> getRegisterApi(String TeamName, String Name,
      String mobileNumber, String userEmail, String referralCode) async {
    //DeviceInfoModel deviceInfoModel = await Utils.getDeviceInfo();
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "deviceDetails": _commonDevice,
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": userEmail,
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": mobileNumber,
        "name": Name,
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "hFb0hdbcItQrK2H4MT2QluSu8cn2",
        "referral_code": referralCode,
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": TeamName,
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": "",
        "user_type": "googleAuth",
        "username": userEmail,
        "version_code": 0,
        "withdraw_amount": 0
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_LOGIN, data: _body);

      log("data print ${_body}");

      CommonResponseModel commonResponseModel =
          CommonResponseModel.fromJson(response.data);
      log("Response Data ${json.encode(response.data)}");

      //   log('Response Data message ${response.data}');
      if (response.statusCode == 200) {
        log("Response Data ${json.encode(response.data)}");

        return LoginModel.fromJson(response.data);
      } else {
        throw new AppException(commonResponseModel.message);
      }
    } catch (error) {
      throw error.toString();
    }
  }

  // Upcoming Matches API

  static Future<MatchesModel> getMatchListData() async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "deviceDetails": {
          "adId": "N/A",
          "appVersion": "alpha11V1.0",
          "brand": "Redmi",
          "country": "",
          "device_id": "69e08f0656131cef",
          "manufacturer": "Xiaomi",
          "model": "M2101K7BI",
          "noOfSIM": -1,
          "os": "N/A(alpha11V1.0)",
          "os_sdk_int": 30,
          "os_version": "11",
          "package_name": "alphaa.cricket",
          "signature": 1178330,
          "timeZone": "GMT+05:30",
          "versionCode": 2062
        },
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "withdraw_amount": 0
      };
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_UPCOMING_MATCHES_DASHBOARD, data: _body);
      // +
      //     "$type/${SharedPreference.getValue(PrefConstants.USER_ID)}",
      // options: Options(headers: {
      //   PrefConstants.ACCESS_TOKEN:
      //       SharedPreference.getValue(PrefConstants.ACCESS_TOKEN),
      //   PrefConstants.REFRESH_TOKEN:
      //       SharedPreference.getValue(PrefConstants.REFRESH_TOKEN)
      // }));
      if (response.statusCode == 200) {
        log("user id ${SharedPreference.getValue(PrefConstants.USER_ID)}");
        log(" resp ${response.data}");
        SharedPreference.setUpcomingMatchData(response.data);
        return MatchesModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Contest API

  static Future<ContestTypeModel> getDefaultContestByType(int matchId) async {
    log("$matchId", name: "getDefaultContestByType()");
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "deviceDetails": {
          "adId": "N/A",
          "appVersion": "alpha11V1.0",
          "brand": "Redmi",
          "country": "",
          "device_id": "69e08f0656131cef",
          "manufacturer": "Xiaomi",
          "model": "M2101K7BI",
          "noOfSIM": -1,
          "os": "N/A(alpha11V1.0)",
          "os_sdk_int": 30,
          "os_version": "11",
          "package_name": "alphaa.cricket",
          "signature": 1178330,
          "timeZone": "GMT+05:30",
          "versionCode": 2062
        },
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "withdraw_amount": 0
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_DEFAULT_CONTEST_BY_TYPE, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        SharedPreference.setAllContestData(response.data);
        return ContestTypeModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Create Team by match id

  static Future<SquadPlayersModel> getSquadsByMatchId(int matchId) async {
    log("$matchId", name: "getDefaultContestByType()");
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "withdraw_amount": 0
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_SQUAD_TEAM, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return SquadPlayersModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Create Team

  static Future<CreateTeamModel> createTeam(
    List<int> finalSquadList,
    int captainId,
    int viceCaptainId,
    int createteamId,
    List<int> teams,
  ) async {
    try {
      Map _body = {
        "captain": captainId,
        "create_team_id": createteamId,
        "deviceDetails": {
          "adId": "N/A",
          "appVersion": "alpha11V1.0",
          "brand": "Redmi",
          "country": "",
          "device_id": "69e08f0656131cef",
          "manufacturer": "Xiaomi",
          "model": "M2101K7BI",
          "noOfSIM": -1,
          "os": "N/A(alpha11V1.0)",
          "os_sdk_int": 30,
          "os_version": "11",
          "package_name": "alphaa.cricket",
          "signature": 1178330,
          "timeZone": "GMT+05:30",
          "versionCode": 2062
        },
        "match_id": SharedPreference.getValue(PrefConstants.MATCH_ID),
        "mobtkn": "9302512306",
        "team_id": teams,
        "teams": finalSquadList,
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "vice_captain": viceCaptainId
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_CREATE_TEAM, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return CreateTeamModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Get MY TEAM API

  static Future<GetMyTeamByIdResponseModel> getMyTeamByPlayerId(
      int matchId) async {
    try {
      Map _body = {
        "match_id": matchId,
        // SharedPreference.getValue(PrefConstants.MATCH_ID),
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_TEAM_BY_USER_ID, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return GetMyTeamByIdResponseModel.fromJson(response.data);
      } else {
        // throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Selected Team Data

  static Future<SelectedTeamModel> getSelectedByPlayerId() async {
    try {
      Map _body = {
        "match_id": SharedPreference.getValue(PrefConstants.MATCH_ID),
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_TEAM_BY_USER_ID, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return SelectedTeamModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Get My Team Detail List

  static Future<GetMyTeam> getMyTeamDetailList(int matchId, int teamId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": teamId,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_MY_TEAM_DETAIL_LIST, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return GetMyTeam.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // View My Team Detail List

  static Future<GetMyTeam> getMyTeamViewDetailList(
      int matchId, int teamId, String userId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": teamId,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": userId,
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_MY_TEAM_DETAIL_LIST, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        log("${matchId}");
        log("${teamId}");
        log("${userId}");
        return GetMyTeam.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // My Contest

  static Future<MyContestModel> getMyContestData(int matchId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_MYCONTEST, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return MyContestModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // My Matches -> My Joined Upcoming Matches

  static Future<MyJoinedUpcomingMatchesModel> getMyJoinedUpcomingMatches(
      String actionType) async {
    try {
      Map _body = {
        "action_type": actionType,
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_JOINEDUPCOMINGMATCHES, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        if (response.data["response"]["matchdata"] != null)
          return MyJoinedUpcomingMatchesModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // My Matches -> My Joined Completed Matches

  static Future<MyCompletedMatchesModel> getMyCompletedMatches(
      String actionType) async {
    try {
      Map _body = {
        "action_type": actionType,
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_JOINEDUPCOMINGMATCHES, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        if (response.data["response"]["matchdata"] != null)
          SharedPreference.setcompletedData(response.data);
        return MyCompletedMatchesModel.fromJson(response.data);
      } else {
        //     throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // My Joined Live Matches

  static Future<MyLiveMatchesModel> getMyLiveMatches(String actionType) async {
    try {
      Map _body = {
        "action_type": actionType,
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": SharedPreference.getValue(PrefConstants.MATCH_ID),
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_JOINEDUPCOMINGMATCHES, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        if (response.data["response"]["matchdata"] != null)
          return MyLiveMatchesModel.fromJson(response.data);
      } else {
        //    throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Get Wallet

  static Future<GetWalletModel> getWallet() async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "withdraw_amount": 0
      };

      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_WALLET, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return GetWalletModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // join New Contest Status

  static Future<JoinNewContestStatusModel> joinNewContestStatus(
      int contestId, int matchId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": contestId,
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "withdraw_amount": 0
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_JOIN_CONTEST_STATUS, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return JoinNewContestStatusModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Select Team Join Contest

  static Future<SelectTeamJoinModel> selectTeamJoinContest(
      int contestId, List<int> createdTeamId, int matchId) async {
    try {
      Map _body = {
        "contest_id": contestId,
        "created_team_id": createdTeamId,
        "match_id": matchId,
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_SELECT_TEAM_JOIN_CONTEST, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        //  return SelectTeamJoinModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // LeaderBoard Model

  static Future<LeaderboardModel> getLeaderBoardData(
      int contestId, int matchId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": contestId,
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_LEADERBOARD, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return LeaderboardModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Prize BreakUp

  static Future<PrizeBreakUpModel> prizeBreakUP(
      int contestId, int matchId) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": contestId,
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": matchId,
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_PRIZEBREAKUP, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return PrizeBreakUpModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // PLAYING hISTORY

  static Future<PlayingHistoryModel> getplayinghistory() async {
    try {
      Map _body = {
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_PLAYINGHISTORY, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        // if (response.data["response"] != null)
        SharedPreference.setPlayingHistoryData(response.data);
        return PlayingHistoryModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Transaction History API

  static Future<TransactionHistoryModel> getTransactionHistory() async {
    try {
      Map _body = {
        "action_type": "",
        "amount": 0,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": "",
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": "",
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID),
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GET_TRANSACTIONHISTORY, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return TransactionHistoryModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Add Money Into Wallet

  static Future<AddMoneyModel> addMoneyIntoWallet(
      num amount, String orderId, String paymentId, String signature) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": amount,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": amount,
        "deviceDetails": {
          "adId": "N/A",
          "appVersion": "Fan11V9.7",
          "brand": "Redmi",
          "country": "",
          "device_id": "69e08f0656131cef",
          "manufacturer": "Xiaomi",
          "model": "M2101K7BI",
          "noOfSIM": -1,
          "os": "N/A(Fan11V9.7)",
          "os_sdk_int": 30,
          "os_version": "11",
          "package_name": "balleballe.cricket",
          "signature": 1178330,
          "timeZone": "GMT+05:30",
          "versionCode": 2067
        },
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": SharedPreference.getValue(PrefConstants.USER_EMAIL) ?? "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number":
            SharedPreference.getValue(PrefConstants.USER_MOB_NO) ?? "",
        "name": "",
        "new_password": "",
        "order_id": orderId,
        "otp": "",
        "password": "",
        "payment_mode": "razorpay",
        "payment_status": "success",
        "payment_taken_in": "",
        "payment_txt": paymentId,
        "paytm_number": "",
        "pinCode": "",
        "player_id": 0,
        "provider_id": "",
        "razorpay_orderid": orderId,
        "referral_code": "",
        "role_type": 0,
        "state": "",
        "team_id": 0,
        "team_name": "",
        "telegram_link": "",
        "token": "",
        "totalPaidAmount": "",
        "transaction_id": signature,
        "userId": "",
        "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
        "user_player_id": "",
        "user_type": "",
        "username": "",
        "version_code": 0,
        "whatsapp_link": "",
        "withdraw_amount": 0,
        "youtubeLink": ""

        // "amount": amount,
        // "deposit_amount": amount,
        // "deviceDetails": {"adId": "N/A"},
        // "email": SharedPreference.getValue(PrefConstants.USER_EMAIL) ?? "",
        // "order_id": orderId,
        // "razorpay_orderid": orderId,
        // "payment_mode": "razorpay",
        // "payment_status": "success",
        // "payment_txt": paymentId,
        // "transaction_id": signature,
        // "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
      };
      log("add money data print ${_body}");
      var response =
          await DioClient.getMyDioClient().post(APIConstants.API_ADD_MONEY,
              options: Options(headers: {
                "Accept": "application/json",
              }),
              data: _body);
      log("${response.statusMessage} ${response.statusCode}", name: "money");
      if (response.statusCode == 200) {
        log("${response.data} ", name: "addmoney");

        return AddMoneyModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // RazorPay OrderId API

  static Future<Razorpayorderid> razorPayOrderId(num amount) async {
    try {
      Map _body = {
        "action_type": "",
        "amount": amount,
        "city": "",
        "competition_id": "",
        "contest_id": "",
        "currency": "",
        "current_password": "",
        "dateOfBirth": "",
        "deposit_amount": "",
        "device_id": "",
        "discountOnBonusAmount": "",
        "documents_type": "",
        "email": "",
        "entryFees": "",
        "event_name": "",
        "facebook_url": "",
        "gender": "",
        "id": 0,
        "image_url": "",
        "match_id": "",
        "mobile_number": "",
        "name": "",
        "new_password": "",
        "order_id": "",
        "otp": "",
        "password": "",
        "payment_mode": "",
        "payment_status": "",
        "payment_taken_in": "",
        "payment_txt": "",
        "paytm_number": ""
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.CREATE_RAZORPAY_ORDER, data: _body);
      // AddMoneyModel commonResponseModel = AddMoneyModel.fromJson(jsonDecode(response.data) );
      log("${response.statusMessage} ${response.statusCode}", name: "razorpay");
      if (response.statusCode == 200) {
        log("${response.data} ", name: "razorpay_order");
        return Razorpayorderid.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  //Update Profile

  static Future<UpdateProfileModel> UpdateProfile (String city, String dob, String male, String image, String mobilenumber,
  String name, String teamName
    ) async {
    try {
      Map _body = {
          "action_type": "",
          "amount": 0,
          "city": city,
          "competition_id": "",
          "contest_id": "",
          "currency": "",
          "current_password": "",
          "dateOfBirth": dob,
          "deposit_amount": "",
          "device_id": "",
          "discountOnBonusAmount": "",
          "documents_type": "",
          "email": SharedPreference.getValue(PrefConstants.USER_EMAIL) ?? "",
          "entryFees": "",
          "event_name": "",
          "facebook_url": "",
          "gender": male,
          "id": 0,
          "image_url":
              image,
          "match_id": "",
          "mobile_number": mobilenumber,
          "name": name,
          "new_password": "",
          "order_id": "",
          "otp": "",
          "password": "",
          "payment_mode": "",
          "payment_status": "",
          "payment_taken_in": "",
          "payment_txt": "",
          "paytm_number": "",
          "pinCode": "",
          "player_id": 0,
          "provider_id": "",
          "razorpay_orderid": "",
          "referral_code": "",
          "role_type": 0,
          "state": "up",
          "team_id": 0,
          "team_name": teamName,
          "telegram_link": "",
          "token": "",
          "totalPaidAmount": "",
          "transaction_id": "",
          "userId": "",
          "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
          "user_player_id": "",
          "user_type": "",
          "username": "",
          "version_code": 0,
          "whatsapp_link": "",
          "withdraw_amount": 0,
          "youtubeLink": ""
        
      };
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.UPDATE_PROFILE, data: _body);
  
      if (response.statusCode == 200) {
        log("${response.data} ", name: "update_profile");
        return UpdateProfileModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // Get User Profile API

  static Future<GetUserModel> getUserData(
      ) async {
    try {
      Map _body = {
      
          "action_type": "",
          "amount": 0,
          "city": "",
          "competition_id": "",
          "contest_id": "",
          "currency": "",
          "current_password": "",
          "dateOfBirth": "",
          "deposit_amount": "",
          "device_id": "",
          "discountOnBonusAmount": "",
          "documents_type": "",
          "email": "",
          "entryFees": "",
          "event_name": "",
          "facebook_url": "",
          "gender": "",
          "id": 0,
          "image_url": "",
          "match_id": "",
          "mobile_number": "",
          "name": "",
          "new_password": "",
          "order_id": "",
          "otp": "",
          "password": "",
          "payment_mode": "",
          "payment_status": "",
          "payment_taken_in": "",
          "payment_txt": "",
          "paytm_number": "",
          "pinCode": "",
          "player_id": 0,
          "provider_id": "",
          "razorpay_orderid": "",
          "referral_code": "",
          "role_type": 0,
          "state": "",
          "team_id": 0,
          "team_name": "",
          "telegram_link": "",
          "token": "",
          "totalPaidAmount": "",
          "transaction_id": "",
          "userId": "",
          "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
          "user_player_id": "",
          "user_type": "",
          "username": "",
          "version_code": 0,
          "whatsapp_link": "",
          "withdraw_amount": 0,
          "youtubeLink": ""
        
      };
     // log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.GETUPDATE_PROFILE, data: _body);

      if (response.statusCode == 200) {
       
        return GetUserModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  // ProfilePic API

  static Future<ProfilePictureModel> profilepicture(String image_bytes, String documents_type) async {
    try {
      Map _body = {
      "image_bytes": image_bytes,
      "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
      "documents_type": documents_type  
      };

     // log("update profile pic print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_UPDATE_PROFILE_PIC, data: _body);

      if (response.statusCode == 200) {
        return ProfilePictureModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }




  // WithDrawal API


  static Future<WithDrawalModel> getwithDraw(String paymentTakenIn, double withDrawalAmount, String paytmNumber) async {
    try {
      Map _body = {
        
          "action_type": "",
          "amount": 0,
          "city": "",
          "competition_id": "",
          "contest_id": "",
          "currency": "",
          "current_password": "",
          "dateOfBirth": "",
          "deposit_amount": "",
          "device_id": "",
          "discountOnBonusAmount": "",
          "documents_type": "",
          "email": SharedPreference.getValue(PrefConstants.USER_EMAIL) ?? "",
          "entryFees": "",
          "event_name": "",
          "facebook_url": "",
          "gender": "",
          "id": 0,
          "image_url": "",
          "match_id": "",
          "mobile_number": SharedPreference.getValue(PrefConstants.USER_MOB_NO) ?? "",
          "name": "",
          "new_password": "",
          "order_id": "",
          "otp": "",
          "password": "",
          "payment_mode": "",
          "payment_status": "",
          "payment_taken_in": paymentTakenIn,
          "payment_txt": "",
          "paytm_number": paytmNumber,
          "pinCode": "",
          "player_id": 0,
          "provider_id": "",
          "razorpay_orderid": "",
          "referral_code": "",
          "role_type": 0,
          "state": "",
          "team_id": 0,
          "team_name": "",
          "telegram_link": "",
          "token": "",
          "totalPaidAmount": "",
          "transaction_id": "",
          "userId": "",
          "user_id": SharedPreference.getValue(PrefConstants.USER_ID) ?? "",
          "user_player_id": "",
          "user_type": "",
          "username": "",
          "version_code": 0,
          "whatsapp_link": "",
          "withdraw_amount": withDrawalAmount,
          "youtubeLink": ""
        
      };
      log("withdrawal_API print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.GET_WITHDRAWAL, data: _body);

      if (response.statusCode == 200) {
        return WithDrawalModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        //   throw commonResponseModel.message;
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }


  // Paytm CheckSum

  static Future<CheckSumModel> checkSum(String mid, String OrderId) async {
    try {
      Map _body = {"MID": mid, "ORDER_ID": OrderId};
      log("data print ${_body}");
      var response = await DioClient.getMyDioClient()
          .post(APIConstants.API_GENERATE_CHECKSUM, data: _body
              // options: Options(headers: {

              //   }
              //  )
              );
      if (response.statusCode == 200) {
        log("${response.data}");
        return CheckSumModel.fromJson(response.data);
      } else {
        throw new AppException(response.statusMessage);
      }
    } catch (error) {
      throw new AppException(error.toString());
    }
  }

  static Map _commonDevice = {
    "adId": "N/A",
    "appVersion": "alpha11V1.0",
    "brand": "Redmi",
    "country": "",
    "device_id": "69e08f0656131cef",
    "manufacturer": "Xiaomi",
    "model": "M2101K7BI",
    "noOfSIM": -1,
    "os": "N/A(alpha11V1.0)",
    "os_sdk_int": 30,
    "os_version": "11",
    "package_name": "alphaa.cricket",
    "signature": 1178330,
    "timeZone": "GMT+05:30",
    "versionCode": 2062
  };
}
