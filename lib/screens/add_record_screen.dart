import 'package:bmi/helpers/bmi_helper.dart';
import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/bmi_record.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/counter_widget.dart';
import 'package:bmi/widgets/cutom_button.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key key}) : super(key: key);

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  int height = 160;
  int weight = 70;
  DateTime initialDOB = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    double space = MediaQuery.of(context).size.height / 6;
    double height = MediaQuery.of(context).size.height;
    double spaceWidth = MediaQuery.of(context).size.width / 8;
    int flex = 8;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Analyzer",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: space / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text("New Record",
                    textAlign: TextAlign.center, style: kHeaderTitleStyle),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: space / 2.3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          getInputTitle(title: "Weight"),
                          SizedBox(
                            width: 55,
                          ),
                          Expanded(
                            flex: flex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CounterWidget(
                                    controller: TextEditingController(
                                      text: this.weight.toString(),
                                    ),
                                    onIncrement: () {
                                      setState(() {
                                        this.weight++;
                                      });
                                    },
                                    onDecrement: () {
                                      print("d");
                                      setState(() {
                                        this.weight--;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "KG",
                                  style: kSubtitleTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          getInputTitle(title: "Height"),
                          SizedBox(
                            width: 55,
                          ),
                          Expanded(
                            flex: flex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CounterWidget(
                                    controller: TextEditingController(
                                      text: this.height.toString(),
                                    ),
                                    onIncrement: () {
                                      setState(() {
                                        this.height++;
                                      });
                                    },
                                    onDecrement: () {
                                      print("d");
                                      setState(() {
                                        this.height--;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "CM",
                                  style: kSubtitleTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // getInputTitle(title: "Date Of Birth"),

                          Text(
                            "Date",
                            style: kSubtitleTextStyle,
                          ),
                          const SizedBox(
                            width: 108,
                          ),

                          getBirthDatePicker(context),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Time",
                            style: kSubtitleTextStyle,
                          ),
                          const SizedBox(
                            width: 104,
                          ),
                          getTimePicker(context),
                        ],
                      ),
                      SizedBox(
                        height: space / 2,
                      ),
                      CustomButton(
                          title: "Save Data",
                          onPressed: () async {
                            print(FirebaseHelper.currentUser.dateOfBirth);

                            BmiRecord bmiRecord = BMIHelper.getRecord(
                                height: this.height,
                                weight: this.weight,
                                gender: FirebaseHelper.currentUser.gender,
                                date: (initialDOB.day.toString() +
                                    "/" +
                                    initialDOB.month.toString() +
                                    "/" +
                                    initialDOB.year.toString()),
                                age: (DateTime.now().year) -
                                    int.tryParse(
                                      FirebaseHelper.currentUser.dateOfBirth
                                          .substring(FirebaseHelper.currentUser
                                                  .dateOfBirth.length -
                                              4),
                                    ));
                            await FirebaseHelper.getInstance()
                                .addRecord(bmiRecord);
                            Navigator.pop(context);
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded getInputTitle({String title}) {
    return Expanded(
      flex: 4,
      child: Text(
        title,
        style: kSubtitleTextStyle,
      ),
    );
  }

  Widget getBirthDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime p = await showDatePicker(
          context: context,
          initialDate: initialDOB,
          firstDate: DateTime(1960),
          lastDate: DateTime.now(),
        );
        setState(() {
          initialDOB = p;
        });
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        width: 130,
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
        child: Text(
          initialDOB.day.toString() +
              "/" +
              initialDOB.month.toString() +
              "/" +
              initialDOB.year.toString(),
          style: kSubtitleTextStyle.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget getTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        setState(() {
          initialTime = time;
        });
      },
      child: Container(
          height: 40,
          alignment: Alignment.center,
          width: 120,
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
          child: Text(
            initialTime.hour.toString() + ":" + initialDOB.minute.toString(),
            style: kSubtitleTextStyle.copyWith(
              color: Colors.black,
            ),
          )),
    );
  }
}
