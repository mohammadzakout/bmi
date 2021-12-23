import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/food_model.dart';
import 'package:bmi/screens/add_record_screen.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/cutom_button.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_food_screen.dart';

class ViewFoodScreen extends StatefulWidget {
  const ViewFoodScreen({Key key}) : super(key: key);

  @override
  State<ViewFoodScreen> createState() => _ViewFoodScreenState();
}

class _ViewFoodScreenState extends State<ViewFoodScreen> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text("Food List",
                  textAlign: TextAlign.center, style: kHeaderTitleStyle),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(child: getFoodListContainer()),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getFoodListContainer() {
    return Container(
      // height: 300,
      // color: Colors.red,

      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 20, left: 20),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseHelper.getInstance().foodStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("No foods are added"));
              }

              return ListView.builder(
                  itemExtent: 130,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data?.docs?.length ?? 0,
                  itemBuilder: (ctx, ind) {
                    Food food = Food.fromJson(snapshot.data.docs[ind].data());

                    return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: new BorderSide(
                                color: kAppBlueColor, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.asset("assets/Noimage.png"),
                            ),
                            Container(
                              width: 2,
                              color: kAppBlueColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      food.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    )),
                                    Expanded(
                                        child: Text(
                                      food.category,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    )),
                                    Expanded(
                                        child: Text(
                                      food.calorie + "cal/g",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    )),
                                  ]),
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Transform.scale(
                                          scale: 0.6,
                                          alignment: Alignment.centerRight,
                                          child: CustomButton(
                                              title: "  Edit  ",
                                              borderRadius: 15,
                                              onPressed: () {
                                                FirebaseHelper.getInstance()
                                                    .setEditFoodDocId(snapshot
                                                        .data.docs[ind].id);

                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return AddFoodScreen(
                                                    edit: true,
                                                    food: food,
                                                  );
                                                }));
                                              }),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Transform.scale(
                                        scale: 0.4,
                                        alignment: Alignment.bottomRight,
                                        child: CustomButton(
                                          title: "X",
                                          borderRadius: 25,
                                          onPressed: () {
                                            FirebaseHelper.getInstance()
                                                .deleteDoc(
                                                    snapshot.data.docs[ind].id);
                                          },
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        )
                        // Column(
                        //   children: [
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           getCellText(title: "dsf"),
                        //           Container(
                        //             width: 1,
                        //             color: kAppBlueColor,
                        //           ),
                        //           getCellText(title: "dsf"),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       height: 1,
                        //       color: kAppBlueColor,
                        //     ),
                        //     Expanded(
                        //       child: Row(
                        //         children: [
                        //           getCellText(title: "dsf"),
                        //           Container(
                        //             width: 1,
                        //             color: kAppBlueColor,
                        //           ),
                        //           getCellText(title: "dsf"),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                        );
                  });
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
