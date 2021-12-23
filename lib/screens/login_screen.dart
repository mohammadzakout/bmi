import 'package:bmi/helpers/constents.dart';
import 'package:bmi/helpers/firebase_helper.dart';
import 'package:bmi/screens/main_screen.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showSpinner = false;
  FirebaseHelper auth = FirebaseHelper.getInstance();
  bool emailIsEmpty = true;
  bool passwordIsEmpty = true;
  Future signIn() async {
    String result =
        await auth.logIn(emailController.text, passwordController.text);
    print(result);
    // Navigator.pushNamed(context, ChatScreen.id);
    setState(() {
      showSpinner = false;
    });
    if (result != null) {
      showAlert(context, result);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
        return const MainScreen();
        // save user data()
      }));
    }
  }

  bool checkSend() {
    setState(() {
      emailIsEmpty = !(emailController.text.length == 0);

      passwordIsEmpty = !(passwordController.text.length <= 5);
      //? false : true;
    });
    return emailIsEmpty && passwordIsEmpty;
  }

  void checkAndLogin() {
    if (checkSend()) {
      setState(() {
        showSpinner = true;
      });

      signIn();
    } else {
      return;
    }
  }

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
                  height: space,
                ),
                Text(
                  "Welcom Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kAppBlueColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "if you already have account , log in",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  title: "Email",
                  controller: emailController,
                  helperText: "enter your email",
                  showHelper: !emailIsEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  title: "Password",
                  helperText: "enter at least 6-letters password",
                  controller: passwordController,
                  showHelper: !passwordIsEmpty,
                ),
                SizedBox(
                  height: space / 2,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkAndLogin();
                  },
                  child: const Text(
                    "LOG IN ",
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
                    const Text("You Don't Have An Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (c) {
                          return const SignUpScreen();
                        }));
                      },
                      child: const Text("Sign Up"),
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
