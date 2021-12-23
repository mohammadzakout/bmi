import 'package:bmi/helpers/constents.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  Function onIncrement;
  Function onDecrement;
  Function onEditingChange;
  TextEditingController controller;

  CounterWidget(
      {this.onIncrement,
      this.onDecrement,
      this.onEditingChange,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // color: Colors.red,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: kAppBlueColor,
            width: 2,
          ),
          bottom: BorderSide(
            color: kAppBlueColor,
            width: 2,
          ),
          left: BorderSide(
            color: kAppBlueColor,
            width: 2,
          ),
          right: BorderSide(
            color: kAppBlueColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          getCounterButton(title: "+", onPressed: onIncrement),
          Expanded(
              flex: 2,
              child: TextField(
                onEditingComplete: onEditingChange,
                controller: controller,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.top,
                enabled: false,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 26,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              )),
          getCounterButton(title: "-", onPressed: onDecrement),
        ],
      ),
    );
  }

  Expanded getCounterButton({String title, Function onPressed}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              // top: BorderSide(
              //   color: kAppBlueColor,
              //   width: 2,
              // ),
              // bottom: BorderSide(
              //   color: kAppBlueColor,
              //   width: 2,
              // ),
              left: BorderSide(
                color: kAppBlueColor,
                width: title == "+" ? 0 : 2,
              ),
              right: BorderSide(
                color: kAppBlueColor,
                width: title == "+" ? 2 : 0,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              color: kAppBlueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
