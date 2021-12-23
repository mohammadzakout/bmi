import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/models/user.dart';
import 'package:bmi/screens/login_screen.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'enter_information_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseHelper auth = FirebaseHelper.getInstance();

  bool nameIsEmpty = true;
  bool isIdentical = true;
  bool phoneNumberIsEmpty = true;
  bool addressIsEmpty = true;
  bool emailIsEmpty = true;
  bool passwordIsNotEnough = true;
  bool checkSend() {
    setState(() {
      nameIsEmpty = !(fullNameController.text.length == 0);
      //  ? false : true;
      // ? false : true;

      emailIsEmpty = !(emailController.text.length == 0);
      // ? false : true;
      // ? false : true;

      passwordIsNotEnough = !(passwordController.text.length < 5);
      //? false : true;
      isIdentical = (passwordController.text == confirmPasswordController.text);
    });
    return nameIsEmpty &&
        phoneNumberIsEmpty &&
        emailIsEmpty &&
        addressIsEmpty &&
        passwordIsNotEnough &&
        isIdentical;
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  void registerAndSave() async {
    BmiAppUser user = BmiAppUser(
      name: fullNameController.text,
      email: emailController.text,
    );

    String result = await auth.registerAndSave(user, passwordController.text);
    print(result);
    // Navigator.pushNamed(context, ChatScreen.id);

    if (result != null) {
      setState(() {
        showSpinner = false;
      });

      // show alert with text
      showAlert(context, result);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
        return const EnterInformationScreen();
      }));
    }

    // save user data()
  }

  void checkAndRegister() {
    if (checkSend()) {
      setState(() {
        showSpinner = true;
      });

      registerAndSave();
    } else {
      return;
    }
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    double space = MediaQuery.of(context).size.height / 6;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: space / 2,
                ),
                Text(
                  "Create New Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kAppBlueColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "if you don't have account",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  title: "name",
                  showHelper: !nameIsEmpty,
                  helperText: "enter your name",
                  controller: fullNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  title: "E-Mail",
                  showHelper: !emailIsEmpty,
                  helperText: "enter your email",
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  title: "Password",
                  controller: passwordController,
                  showHelper: !passwordIsNotEnough,
                  helperText: "enter at least 6-letter password",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  title: "Re-Password",
                  controller: confirmPasswordController,
                  showHelper: !isIdentical,
                  helperText: "passwords are not identical",
                ),
                SizedBox(
                  height: space / 2.4,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkAndRegister();
                  },
                  child: const Text(
                    "CREATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(0, 60)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => kAppBlueColor)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You Have An Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
