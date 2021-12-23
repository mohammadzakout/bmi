import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/food_model.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/cutom_button.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class AddFoodScreen extends StatefulWidget {
  AddFoodScreen({this.edit, Key key, this.food}) : super(key: key);
  bool edit;
  Food food;

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  void initState() {
    super.initState();
    foodName = TextEditingController();
    category = TextEditingController();
    calorie = TextEditingController();
    if (widget.edit) {
      foodName.text = widget.food.name;
      category.text = widget.food.category;
      calorie.text = widget.food.calorie;
    }
  }

  String selectedGender = Gender.male;
  TextEditingController foodName;
  TextEditingController category;
  TextEditingController calorie;
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                    (widget.edit ?? false)
                        ? "Edit Food Details"
                        : "Add Food Details",
                    textAlign: TextAlign.center,
                    style: kHeaderTitleStyle),
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
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          getInputTitle(title: "Name"),
                          SizedBox(
                            width: 55,
                          ),
                          Expanded(
                            flex: flex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: getInputField(foodName),
                                ),
                                const SizedBox(
                                  width: 35,
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
                          getInputTitle(title: "Category"),
                          SizedBox(
                            width: 55,
                          ),
                          Expanded(
                            flex: flex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: getInputField(category),
                                ),
                                SizedBox(
                                  width: 35,
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
                          getInputTitle(title: "Calorie"),
                          SizedBox(
                            width: 55,
                          ),
                          Expanded(
                            flex: flex,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: getInputField(calorie),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "cal/g",
                                  style: kSubtitleTextStyle.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
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
                          Text(
                            "Photo",
                            style: kSubtitleTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          height: 300,
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
                          child: Image.asset("assets/Noimage.png")),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: CustomButton(title: "Upload Image")),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 1,
                              child: CustomButton(
                                title: "Save",
                                onPressed: () async {
                                  Food food = Food(
                                    name: foodName.text,
                                    category: category.text,
                                    calorie: calorie.text,
                                  );
                                  if (widget.edit) {
                                    await FirebaseHelper.getInstance()
                                        .editFood(food);
                                  } else {
                                    await FirebaseHelper.getInstance()
                                        .addFood(food);
                                  }

                                  Navigator.pop(context);
                                },
                              )),
                        ],
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

  Widget getInputField(TextEditingController controller) {
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
          Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              )),
        ],
      ),
    );
  }

  Widget getBirthDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1960),
            lastDate: DateTime.now());
      },
      child: Container(
        height: 40,
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
      ),
    );
  }

  Widget getTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
      },
      child: Container(
        height: 40,
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
      ),
    );
  }
}
