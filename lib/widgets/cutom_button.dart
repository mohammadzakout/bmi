import 'package:bmi/helpers/constents.dart';
import 'package:bmi/screens/main_screen.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.title,
    this.onPressed,
    this.borderRadius,
    Key key,
  }) : super(key: key);
  String title;
  Function onPressed;
  double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        this.title ?? "",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  side: BorderSide(color: kAppBlueColor))),
          minimumSize:
              MaterialStateProperty.resolveWith((states) => Size(0, 60)),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => kAppBlueColor)),
    );
  }
}
