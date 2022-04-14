import 'dart:io';

import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorConstant.COLOR_RED,
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                ImgConstants.balleballe11_BACKGROUND_REMOVE,
                fit: BoxFit.cover,
                color: ColorConstant.COLOR_WHITE,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              SizedBox(height: 10.0),
              Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "We're offline!",
                    style: TextStyle(
                      color: ColorConstant.COLOR_WHITE,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Image.asset(
                    ImgConstants.IC_MAINTENANCE_IMAGE,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Unfortunately the app is down for a bit of maintenance right now. We will be online as soon as possible. Please check again in a little while. Thank you!",
                    style: TextStyle(
                      color: ColorConstant.COLOR_WHITE,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text("Exit App!"),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        exit(0);
      },
    );
  }
}
