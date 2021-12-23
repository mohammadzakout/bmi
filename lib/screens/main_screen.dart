import 'package:bmi/helpers/bmi_helper.dart';
import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/bmi_record.dart';
import 'package:bmi/screens/add_record_screen.dart';
import 'package:bmi/screens/login_screen.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/screens/view_food_screen.dart';
import 'package:bmi/widgets/cutom_button.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_food_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedGender = Gender.male;
  @override
  Widget build(BuildContext context) {
    double space = MediaQuery.of(context).size.height / 6;
    double spaceWidth = MediaQuery.of(context).size.width / 8;
    int flex = 7;
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
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text("Hi " + FirebaseHelper.currentUser.name,
                textAlign: TextAlign.center,
                style: kHeaderTitleStyle.copyWith(
                  color: Colors.black,
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(
              height: 20,
            ),
            getTitle(title: "Current Status"),
            const SizedBox(
              height: 15,
            ),
            getCurrentStatusContainer(),
            const SizedBox(
              height: 20,
            ),
            getTitle(title: "Old Status"),
            const SizedBox(
              height: 10,
            ),
            getOldStatusContainer(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Add Food",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return AddFoodScreen(
                          edit: false,
                        );
                      }));
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomButton(
                    title: "Add Record",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const AddRecordScreen();
                      }));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
                title: "View Food",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const ViewFoodScreen();
                  }));
                }),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseHelper.getInstance().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const LoginScreen();
                  }));
                },
                child: Text(
                  "logout",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String currentState = "";
  Widget getOldStatusContainer() {
    return Container(
      height: 300,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: kAppBlueColor,
        borderRadius: BorderRadius.circular(5),
        border: Border(
          top: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          bottom: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          left: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          right: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 35, left: 35),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseHelper.getInstance().recordsStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text("No Records"),
                );
              } else {
                int length = snapshot?.data?.docs?.length ?? 0;
                if (length == 0) currentState = "No Data ";
                if (length == 1)
                  currentState =
                      ((snapshot?.data?.docs?.first?.data() as Map)["status"] ??
                          "");
                if (length >= 2) {
                  currentState = BMIHelper.getCurrentStatus(
                          current: ((snapshot?.data?.docs?.first?.data()
                                  as Map)["record"] ??
                              0),
                          previous: (snapshot?.data?.docs[1]?.data() as Map ??
                                  {"record": 0})["record"] ??
                              0,
                          oldStatus: (snapshot?.data?.docs[1]?.data()
                                  as Map)["status"] ??
                              "") +
                      "!";
                }

                // currentState = BMIHelper.getCurrentStatus(
                //         previous:
                //             ((snapshot?.data?.docs?.first?.data() as Map ??
                //                     {"record": 0})["record"] ??
                //                 0),
                //         current: (snapshot?.data?.docs[1]?.data() as Map ??
                //                 {"record": 0})["record"] ??
                //             0,
                //         oldStatus: (snapshot?.data?.docs?.first?.data()
                //                 as Map)["status"] ??
                //             "") +
                //     "!";
                if (!mounted) setState(() {});
                try {
                  return ListView.builder(
                      itemExtent: 100,
                      padding: EdgeInsets.zero,
                      itemCount: snapshot.data?.docs?.length ?? 0,
                      itemBuilder: (ctx, ind) {
                        BmiRecord record =
                            BmiRecord.fromJson(snapshot.data.docs[ind].data());
                        return Card(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    getCellText(title: record.date),
                                    Container(
                                      width: 1,
                                      color: kAppBlueColor,
                                    ),
                                    getCellText(
                                        title:
                                            record.weight.toString() + " KG"),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: kAppBlueColor,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    getCellText(
                                        title: record.status.toString()),
                                    Container(
                                      width: 1,
                                      color: kAppBlueColor,
                                    ),
                                    getCellText(
                                        title:
                                            record.height.toString() + " CM"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } catch (e) {
                  return Center(
                    child: Text("No Records"),
                  );
                }
              }
            }),
      ),
    );
  }

  Expanded getCellText({String title}) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Text getTitle({String title}) {
    return Text(
      title,
      style: kSubtitleTextStyle.copyWith(fontSize: 20),
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

  Widget getCounter() {
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
          getCounterButton(title: "+"),
          Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              )),
          getCounterButton(title: "-"),
        ],
      ),
    );
  }

  Widget getCurrentStatusContainer() {
    return Container(
      height: 60,
      // color: Colors.red,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border(
          top: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          bottom: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          left: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
          right: BorderSide(
            color: kAppBlueColor,
            width: 1,
          ),
        ),
      ),
      child: Text(
        currentState ?? "",
      ),
    );
  }

  Expanded getCounterButton({String title}) {
    return Expanded(
      flex: 1,
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
    );
  }
}
