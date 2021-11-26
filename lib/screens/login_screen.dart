import 'package:bmi/helpers/constents.dart';
import 'package:bmi/screens/signup_screen.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

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
      body: Padding(
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
            const AppTextField(title: "Username"),
            const SizedBox(
              height: 20,
            ),
            const AppTextField(title: "Password"),
            SizedBox(
              height: space / 2,
            ),
            ElevatedButton(
              onPressed: () {},
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) {
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
    );
  }
}
