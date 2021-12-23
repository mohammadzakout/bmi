import 'package:bmi/helpers/bmi_helper.dart';
import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/bmi_record.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/counter_widget.dart';
import 'package:bmi/widgets/cutom_button.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'main_screen.dart';

class EnterInformationScreen extends StatefulWidget {
  const EnterInformationScreen({Key key}) : super(key: key);

  @override
  State<EnterInformationScreen> createState() => _EnterInformationScreenState();
}

class _EnterInformationScreenState extends State<EnterInformationScreen> {
  String selectedGender = Gender.male;
  int height = 160;
  int weight = 70;
  DateTime initialDOB = DateTime(
    1999,
  );
  @override
  Widget build(BuildContext context) {
    double space = MediaQuery.of(context).size.height / 6;
    double height = MediaQuery.of(context).size.height;
    bool showSpinner = false;
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                SizedBox(
                  height: space / 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Complete Your Information",
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
                            getInputTitle(title: "Gender"),
                            const SizedBox(
                              width: 26,
                            ),
                            Expanded(
                              flex: flex,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: getGenderRadiobutton(
                                        title: "Male", genderId: Gender.male),
                                  ),
                                  Expanded(
                                    child: getGenderRadiobutton(
                                        title: "Female",
                                        genderId: Gender.female),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          children: [
                            Text(
                              "Date Of Birth",
                              style: kSubtitleTextStyle,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            getBirthDatePicker(context),
                          ],
                        ),
                        SizedBox(
                          height: space / 2,
                        ),
                        CustomButton(
                          title: "Save Data",
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            await FirebaseHelper.getInstance().setInformation(
                              gender: selectedGender,
                              height: this.height,
                              weight: this.weight,
                              dof: (initialDOB.day.toString() +
                                  "/" +
                                  initialDOB.month.toString() +
                                  "/" +
                                  initialDOB.year.toString()),
                            );
                            await FirebaseHelper.getInstance().saveData();
                            await FirebaseHelper.getInstance()
                                .addRecord(BMIHelper.getRecord(
                              gender: selectedGender,
                              height: this.height,
                              weight: this.weight,
                              age: initialDOB.year,
                              date: (initialDOB.day.toString() +
                                  "/" +
                                  initialDOB.month.toString() +
                                  "/" +
                                  initialDOB.year.toString()),
                            ));
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return const MainScreen();
                                },
                              ),
                            );
                          },
                        ),
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

  void selectGender(String genderId) {
    setState(() {
      selectedGender = genderId;
    });
  }

  Widget getGenderRadiobutton({String title, String genderId}) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => selectGender(genderId),
      child: Row(
        children: [
          Radio(
            onChanged: (_) => selectGender(genderId),
            groupValue: selectedGender,
            value: genderId,
            splashRadius: 0,

            fillColor:
                MaterialStateProperty.resolveWith((states) => kAppBlueColor),
            // fillColor: MaterialStateProperty.resolveWith(
            //     (states) => kAppBlueColor),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: kAppBlueColor,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget getCounter(
  //     {Function onIncrement,
  //     Function onDecrement,
  //     Function onEditingChange,
  //     TextEditingController controller}) {
  //   return Container(
  //     height: 40,
  //     // color: Colors.red,
  //     decoration: BoxDecoration(
  //       border: Border(
  //         top: BorderSide(
  //           color: kAppBlueColor,
  //           width: 2,
  //         ),
  //         bottom: BorderSide(
  //           color: kAppBlueColor,
  //           width: 2,
  //         ),
  //         left: BorderSide(
  //           color: kAppBlueColor,
  //           width: 2,
  //         ),
  //         right: BorderSide(
  //           color: kAppBlueColor,
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     child: Row(
  //       children: [
  //         getCounterButton(title: "+", onPressed: onIncrement),
  //         Expanded(
  //             flex: 2,
  //             child: TextField(
  //               onEditingComplete: onEditingChange,
  //               controller: controller,
  //               keyboardType: TextInputType.number,
  //               textAlignVertical: TextAlignVertical.top,
  //               enabled: false,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //                 fontSize: 26,
  //               ),
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //               ),
  //             )),
  //         getCounterButton(title: "-", onPressed: onDecrement),
  //       ],
  //     ),
  //   );
  // }

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
        width: 120,
        alignment: Alignment.center,
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
}
