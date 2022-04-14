import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final String progressText;

  ProgressWidget(this.progressText);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircularProgressIndicator(
          // backgroundColor: ColorConstant.COLOR_RED,
          strokeWidth: 3.0,
          // valueColor:
          //     new AlwaysStoppedAnimation(ColorConstant.BACKGROUND_COLOR),
        ),
      ),
    );
  }
}
