import 'package:fluttertoast/fluttertoast.dart';

void customToast({
  required String message,
  ToastGravity gravity = ToastGravity.BOTTOM,
  int timeInSecForIosWeb = 1,
  double fontSize = 16.0,
}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: gravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    fontSize: fontSize,
  );
}
