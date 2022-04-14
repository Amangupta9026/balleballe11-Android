import 'dart:developer';

import 'package:balleballe11/apiService/apiServices.dart';
import 'package:device_preview/device_preview.dart';
import 'package:balleballe11/login/login.dart';
import 'package:balleballe11/sharedPreference/sharedPreference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:balleballe11/constance/constance.dart' as constance;
import 'package:balleballe11/constance/routepath.dart' as routePath;
import 'package:flutter/services.dart';

import 'constance/apiConstants.dart';
import 'constance/constance.dart';
import 'constance/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreference.init();
//   runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static setCustomeTheme(BuildContext context, int index) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state?.setCustomeTheme(index);
  }

  static setCustomeLanguage(BuildContext context, String languageCode) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLanguage(languageCode);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    } else {
      setState(() {
        constance.colorsIndex = index;
        constance.primaryColorString =
            OtherConstants().colors[constance.colorsIndex];
        constance.secondaryColorString = constance.primaryColorString;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // if (SharedPreference.getValue(PrefConstants.USER_ID) != null) {
    //   Future.delayed(Duration.zero, () {
    //     APIServices.getMyCompletedMatches("completed");
    //   });
    // }
    // log("user main id ${SharedPreference.getValue(PrefConstants.USER_ID)}");
  }

  final String locale = "en";

  setLanguage(String languageCode) {
    setState(() {
      // locale = languageCode;
      constance.locale = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    constance.locale = locale;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      title: 'balleballe11',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: routePath.RoutePath.initRoutePath,
      onGenerateRoute: routePath.generateRoute,
    );
  }
}
