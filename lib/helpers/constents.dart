import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Color kAppBlueColor = const Color(0xFF1689D8);
TextStyle kHeaderTitleStyle = TextStyle(
  color: kAppBlueColor,
  fontSize: 30,
  fontWeight: FontWeight.w800,
);
TextStyle kSubtitleTextStyle = TextStyle(
  color: kAppBlueColor,
  fontSize: 22,
  fontWeight: FontWeight.w700,
);

class Gender {
  static String male = "Male";
  static String female = "Female";
}

void showAlert(BuildContext context, String text) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "خطأ",
    desc: text,
    buttons: [
      DialogButton(
        child: Text(
          "الغاء",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
