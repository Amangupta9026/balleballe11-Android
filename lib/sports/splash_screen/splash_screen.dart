import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:balleballe11/Language/LanguageData.dart';
import 'package:balleballe11/apiService/apiServices.dart';
import 'package:balleballe11/apiService/dioClient.dart';
import 'package:balleballe11/constance/apiConstants.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/home_page/home_screen.dart';
import 'package:balleballe11/login/login.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/sharedPreference/sharedPreference.dart';
import 'package:balleballe11/widget/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:balleballe11/constance/constance.dart' as constance;
import 'package:video_player/video_player.dart';

import 'apk_download_page.dart';

class My11ChoiceSplashPage extends StatefulWidget {
  _My11ChoiceSplashPageState createState() => _My11ChoiceSplashPageState();
}

class _My11ChoiceSplashPageState extends State<My11ChoiceSplashPage> {

  VideoPlayerController _controller;
  bool _visible = false;

  
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  FirebaseMessaging _firebaseMessaging;
  bool isDevOpEnabled = false;
  String package_buildnumber;
  final int buildnumber = 3;

  MyCompletedMatchesModel _matchCompleteeData = MyCompletedMatchesModel();
  List<Completed> _completedMatchLists = <Completed>[];
  bool _isProgressRunning = false;

  // var upcomingmatchdata;
  // var bannerimagedata;
  // var joinedmatchdata;

  @override
  void initState() {
    print("apk data fetch");

    myContext = context;

    _initPackageInfo().then((value) => null);
    _loadNextScreen();
    package_buildnumber = _packageInfo.buildNumber;
    super.initState();


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset("assets/video/splash_video.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 10), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
    
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      package_buildnumber = info.buildNumber;
      _packageInfo = info;
    });
  }

  

  BuildContext myContext;

  _loadNextScreen() async {
    if (!mounted) return;
    // if (constance.allTextData == null) {
    //   constance.allTextData = AllTextData.fromJson(
    //     json.decode(
    //       await DefaultAssetBundle.of(myContext)
    //           .loadString("jsonFile/languagetext.json"),
    //     ),
    //   );
    // }

    if (await InternetUtils.internetCheck()) {
      _firebaseMessaging = FirebaseMessaging.instance;
      String firebaseToken = await _firebaseMessaging.getToken();
      log("$firebaseToken", name: "My Firebase Token");
      //  log(_packageInfo.buildNumber, name: "Package Info");
      log(package_buildnumber, name: "Package Info again");
      log(_packageInfo.buildNumber, name: "package value");
      if (!isDevOpEnabled) {
        SharedPreference.setValue(
            PrefConstants.FIREBASE_TOKEN, firebaseToken ?? "");

        if (SharedPreference.getValue(PrefConstants.IS_LOGIN,
            defaultValue: false)) {
          Timer(Duration(seconds: 3), () async {
            // var objCheckVersion = await APIServices.checkVersionUpdate(
            //   package_buildnumber,
            // );

            if (buildnumber < 2
                //  int.parse(objCheckVersion.data.versionCode)
                ) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => APKDownloadPage(
                      // releasenote: objCheckVersion.data.releaseNotes,
                      // apkfile: objCheckVersion.data.apkFile,
                      // releasetitle: objCheckVersion.data.releaseTitle,
                      ),
                ),
              );
            } else {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
                (route) => false,
              );
            }
          });
        } else {
          Timer(Duration(seconds: 4), () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => LoginPage(),
              ),
              (route) => false,
            );
          });
        }
      } else {
        showCommonMessageDialog(context,
            "We do not allow in Developer Mode.Please disable your developer mode");
      }
    } else {
      InternetUtils.networkErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    return Material(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              _getVideoBackground(),
            ],
          ),
        ),

        // Image.asset(ImgConstants.SPLASH_BG,
        //     height: MediaQuery.of(context).size.height,
        //     width: MediaQuery.of(context).size.width,
        //     fit: BoxFit.cover),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 10),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(color: Colors.transparent //.withAlpha(120),
        );
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

}
