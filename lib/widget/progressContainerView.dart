import 'package:balleballe11/widget/progressWidget.dart';
import 'package:flutter/material.dart';

class ProgressContainerView extends StatelessWidget {
  Widget child;
  Widget progressWidget;
  bool isProgressRunning;
  String progressText;
  double progressWidgetOpacity;

  ProgressContainerView(
      {this.child,
      this.isProgressRunning,
      this.progressText = "",
      this.progressWidgetOpacity = 0.6,
      this.progressWidget});

  @override
  Widget build(BuildContext context) {
    if (progressText == "Please Wait") {
      progressText = "Please Wait...";
    }
    return Stack(
      children: <Widget>[
        child,
        Visibility(
            visible: isProgressRunning,
            child: Container(
                color: Colors.grey.withOpacity(progressWidgetOpacity),
                child: progressWidget ?? ProgressWidget(this.progressText))),
      ],
    );
  }
}
