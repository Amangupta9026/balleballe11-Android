import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class APKDownloadPage extends StatefulWidget {
  final String releasetitle;
  final String apkfile;
  final String releasenote;

  const APKDownloadPage(
      {Key key, this.releasetitle, this.apkfile, this.releasenote})
      : super(key: key);

  @override
  _APKDownloadPageState createState() => _APKDownloadPageState();
}

enum APKDownloadType {
  normal,
  startDownload,
  completeDownload,
}

class _APKDownloadPageState extends State<APKDownloadPage> {
  APKDownloadType _apkDownloadType = APKDownloadType.normal;
  double _totalPercentage = 0;
  String _percentage = "0%";
  String _downloadAPKFilePath;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE,
      systemNavigationBarColor: Colors.transparent,
    ));

    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: ColorConstant.BACKGROUND_COLOR,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(bottom: 15.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImgConstants.SPLASH_BG,
                  fit: BoxFit.cover,
                  height: 350.0,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ff",
                          // widget.releasetitle != null
                          //     ? widget.releasetitle
                          //     : '',

                          style: TextStyle(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "dd",
                          //  widget.releasenote ?? "",

                          style: TextStyle(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "While downloading the APK do not close the app or don't press the back button.",
                          style: TextStyle(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40.0),
                        LinearPercentIndicator(
                          animation: true,
                          padding: EdgeInsets.all(3.0),
                          lineHeight: 8.0,
                          percent: _totalPercentage,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: ColorConstant.COLOR_PROGRESS_GREY,
                          progressColor: ColorConstant.COLOR_RED,
                          animateFromLastPercent: true,
                          leading: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(_percentage),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("100%"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _apkDownloadType == APKDownloadType.normal ||
                              _apkDownloadType ==
                                  APKDownloadType.completeDownload
                          ? () async {
                              if (_apkDownloadType == APKDownloadType.normal) {
                                _downloadAPK();
                              } else if (_apkDownloadType ==
                                  APKDownloadType.completeDownload) {
                                await OpenFile.open(_downloadAPKFilePath);
                                print(OpenFile.open(_downloadAPKFilePath));
                                //   exit(0);
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstant.COLOR_RED,
                        fixedSize: Size(150.0, 0.0),
                      ),
                      child: Text(
                        _apkDownloadType == APKDownloadType.completeDownload
                            ? "Install"
                            : _apkDownloadType == APKDownloadType.startDownload
                                ? "Downloading..."
                                : "Download",
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadAPK() async {
    if (await Permission.storage.request().isGranted) {
      try {
        setState(() {
          _apkDownloadType = APKDownloadType.startDownload;
        });
        Dio dio = Dio();

        String apkURL = 'https://balleballe11.in/upload/apk/balleballe11.apk';
        //  widget.apkfile ??
        //     'https://balleballe11.in/upload/apk/balleballe11.apk';

        String fileName = "balleballe11.apk";

        final String downloadDirectory =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOADS);
        _downloadAPKFilePath = "$downloadDirectory/$fileName";

        await dio.download(
          apkURL,
          _downloadAPKFilePath,
          onReceiveProgress: (rec, total) {
            setState(() {
              _percentage = ((rec / total) * 100).toStringAsFixed(0) + "%";
              _totalPercentage = ((rec / total) * 100) / 100;
            });
          },
        );

        setState(() {
          _apkDownloadType = APKDownloadType.completeDownload;
          print(_apkDownloadType);
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      var permissionResult = await Permission.storage.request();
      if (permissionResult.isDenied || permissionResult.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('Camera Permission'),
            content: Text('This app needs storage access to store the apk.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Deny'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        );
      }
    }
  }
}
