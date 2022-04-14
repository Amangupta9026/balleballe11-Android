import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/model/deviceInfoModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static Future<DeviceInfoModel> getDeviceInfo() async {
    DeviceInfoModel deviceInfoModel;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      log("${androidDeviceInfo.brand}", name: "1");
      log("${androidDeviceInfo.model}", name: "2");
      log("${androidDeviceInfo.id}", name: "3");
      log("${androidDeviceInfo.androidId}", name: "4");
      log("${androidDeviceInfo.board}", name: "5");
      log("${androidDeviceInfo.bootloader}", name: "6");
      log("${androidDeviceInfo.device}", name: "7");
      log("${androidDeviceInfo.display}", name: "8");
      log("${androidDeviceInfo.fingerprint}", name: "9");
      log("${androidDeviceInfo.hardware}", name: "10");
      log("${androidDeviceInfo.host}", name: "11");
      log("${androidDeviceInfo.isPhysicalDevice}", name: "12");
      log("${androidDeviceInfo.manufacturer}", name: "13");
      log("${androidDeviceInfo.tags}", name: "14");
      log("${androidDeviceInfo.type}", name: "15");
      log("${androidDeviceInfo.product}", name: "16");
      log("${androidDeviceInfo.version.baseOS}", name: "17");
      log("${androidDeviceInfo.version.codename}", name: "18");
      log("${androidDeviceInfo.version.incremental}", name: "19");
      log("${androidDeviceInfo.version.previewSdkInt}", name: "20");
      log("${androidDeviceInfo.version.release}", name: "21");
      log("${androidDeviceInfo.version.securityPatch}", name: "22");
      deviceInfoModel = DeviceInfoModel(
          deviceId: androidDeviceInfo.androidId,
          deviceName: androidDeviceInfo.brand,
          deviceOS: androidDeviceInfo.version.release,
          deviceFirebaseToken: androidDeviceInfo.brand);
      return deviceInfoModel;
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      log("${iosDeviceInfo.name}", name: "iosDeviceInfo");
      deviceInfoModel = DeviceInfoModel(
        // deviceId: iosDeviceInfo. ,
        deviceName: iosDeviceInfo.name,
        //  deviceOS: iosDeviceInfo.
      );
      return deviceInfoModel;
    }
  }

  static String getShortName(String shortname) {
    String sName = "";
    /**
     * Write your logic to shorten the name of the players
      */

    if (shortname == null) {
      return shortname;
    } else {
      var parts = shortname.split(" ");

      var firstChar = parts[0].trim();
      //   sName = firstChar[0] + ' '+ parts[parts.length-1];
      for (int i = 0; i < parts.length; i++) {
        if (i == (parts.length - 1)) {
          sName = sName + parts[i];
        } else {
          sName = sName + parts[i][0] + " ";
        }
      }
    }

    return sName;
  }

  static getMontserratRegularFont() {
    return "Montserrat";
  }

  static bool isValidEmail(String emailAddress) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailAddress);
  }
}

class DateTimeUtils {
  static String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy hh:mm:ss aa').format(dateTime);
  }

  static DateTime now() {
    return DateTime.now(); //.toUtc().add(globals.timeZoneInfo.timeZoneOffset);
  }

  static Future<Map> getDeviceInfo() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await plugin.androidInfo;
      return {
        "platform": "Android",
        "deviceId": info.androidId,
        "manufacturer": info.manufacturer,
        "model": info.model,
        "version": info.version.release,
        "isPhysicalDevice": info.isPhysicalDevice,
      };
    } else if (Platform.isIOS) {
      var info = await plugin.iosInfo;
      return {
        "platform": "iOS",
        "deviceId": info.identifierForVendor,
        "manufacturer": "Apple",
        "model": info.model,
        "version": info.systemVersion,
        "isPhysicalDevice": info.isPhysicalDevice,
      };
    }
    return {};
  }
}

class PermissionUtils {
  static void showPermissionSettingsDialog(
      BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text(content),
            actions: <Widget>[
              InkWell(
                child: Text("open settings"),
                onTap: () {
                  Navigator.of(ctx).pop();
                  openAppSettings();
                },
              )
            ],
          );
        });
  }
}

class InternetUtils {
  static Future<bool> internetCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static networkErrorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Oops!",
            style: TextStyle(
                color: ColorConstant.COLOR_BLACK,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
          content: new Text(
            "Please check your internet connection",
            style: TextStyle(
                color: ColorConstant.COLOR_TEXT,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            new InkWell(
              child: new Text(
                "OK",
                style: TextStyle(
                    color: ColorConstant.COLOR_RED,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
