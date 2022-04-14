import 'package:balleballe11/constance/packages.dart';

class UtilsFlushBar {
  static void showDefaultSnackbar(BuildContext context, content) {
    Flushbar(
      message: content,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: ColorConstant.COLOR_RED,
      //  backgroundColor: Colors.purple,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
