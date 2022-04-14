import 'dart:convert';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/playing_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences _pref;

  static Future init() async {
    return SharedPreferences.getInstance().then((_p) {
      _pref = _p;
    });
  }

  static dynamic getValue(String key, {dynamic defaultValue}) {
    if (_pref.containsKey(key)) {
      return _pref.get(key);
    } else {
      return defaultValue;
    }
  }

  static clearPrefs() {
    //String fcmToken = getValue(PrefConstants.FCM_TOKEN);
    _pref.clear();
    //setValue(PrefConstants.FCM_TOKEN, fcmToken);
  }

  static void setValue(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
        _pref.setString(key, value);
        return;
      case bool:
        _pref.setBool(key, value);
        return;
      case double:
        _pref.setDouble(key, value);
        return;
      case int:
        _pref.setInt(key, value);
        return;
      case List:
        _pref.setStringList(key, value);
        return;
    }
  }

  // Upcoming Data
  static MatchesModel getUpcomingMatchData() {
    String upcomingData = _pref.getString("upcomingdata");
    if (upcomingData == null) {
      return null;
    } else {
      var data = jsonDecode(_pref.getString("upcomingdata") ?? "");
      return MatchesModel.fromJson(data);
    }
  }

  static setUpcomingMatchData(value) async {
    var upcomingdata = jsonEncode(value);
    _pref.setString("upcomingdata", upcomingdata);
  }

  // All Contest Page

  static ContestTypeModel getAllContestData() {
    String allcontestData = _pref.getString("allcontestData");
    if (allcontestData == null) {
      return null;
    } else {
      var data = jsonDecode(_pref.getString("allcontestData") ?? "");
      return ContestTypeModel.fromJson(data);
    }
  }

  static setAllContestData(value) async {
    var allcontestData = jsonEncode(value);
    _pref.setString("allcontestData", allcontestData);
  }

  // Completed Match

  static MyCompletedMatchesModel getcompletedData() {
    String completedData = _pref.getString("completedData");
    if (completedData == null) {
      return null;
    } else {
      var data = jsonDecode(_pref.getString("completedData") ?? "");
      return MyCompletedMatchesModel.fromJson(data);
    }
  }

  static setcompletedData(value) async {
    var completedData = jsonEncode(value);
    _pref.setString("completedData", completedData);
  }

  // PLaying Match History

  static PlayingHistoryModel getPlayingHistoryData() {
    String playingData = _pref.getString("playingData");
    if (playingData == null) {
      return null;
    } else {
      var data = jsonDecode(_pref.getString("playingData") ?? "");
      return PlayingHistoryModel.fromJson(data);
    }
  }

  static setPlayingHistoryData(value) async {
    var playingData = jsonEncode(value);
    _pref.setString("playingData", playingData);
  }
}
