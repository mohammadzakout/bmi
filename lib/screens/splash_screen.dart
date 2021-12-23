import 'package:bmi/helpers/constents.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBlueColor,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 200,
          width: 200,
        ),
      ),
      floatingActionButton: TextButton(
        child: const Text(
          "Next",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
