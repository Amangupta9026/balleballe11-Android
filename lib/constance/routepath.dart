import 'package:balleballe11/login/login.dart';
import 'package:balleballe11/sports/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutePath.initRoutePath:
      return MaterialPageRoute(builder: (context) => My11ChoiceSplashPage());
      break;

    case RoutePath.userProfileRoutePath:
      return MaterialPageRoute(builder: (context) => LoginPage());
      break;

    default:
      return MaterialPageRoute(builder: (context) => My11ChoiceSplashPage());
  }
}

class RoutePath {
  static const String initRoutePath = "/";
  static const String loginRoutePath = "login";
  static const String homeRoutePath = "home";
  static const String registerRoutePath = "register";
  static const String userProfileRoutePath = "userprofileRegister";
  // static const String matchAllContestRoutePath = "matchAllContest";
  // static const String contestDetailsRoutePath = "contestDetail";
  // static const String createTeamRoutePath = "createTeam";
  // static const String chooseCapVCRoutePath = "chooseCapVC";
  // static const String myMatchesRoutePath = "myMatches";
  // static const String morePageRoutePath = "morepage";
  // static const String teamPreviewRoutePath = "teampreview";
  // static const String cricketRoutePath = "cricket";

// static const String setNotificationRoutePath = "patient/setNotification";
// static const String setRemindersRoutePath = "patient/setReminders";
// static const String forgotPasswordRoutePath = "patient/forgotpassword";
// static const String googleCheck = "patient/google";
// static const String allAppointmentRoutePath = "patient/allAppointments";
// static const String pendingAppointmentRoutePath =
//     "patient/pendingAppointments";
// static const String changePwdRoutePath = "patient/changePwd";
}
