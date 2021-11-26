import 'package:bmi/helpers/constents.dart';
import 'package:bmi/screens/login_screen.dart';
import 'package:bmi/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

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
            const AppTextField(title: "name"),
            const SizedBox(
              height: 10,
            ),
            const AppTextField(title: "E-Mail"),
            const SizedBox(
              height: 10,
            ),
            const AppTextField(title: "Password"),
            const SizedBox(
              height: 10,
            ),
            const AppTextField(title: "Re-Password"),
            SizedBox(
              height: space / 2.4,
            ),
            ElevatedButton(
              onPressed: () {},
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
    );
  }
}
