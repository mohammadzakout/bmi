import 'dart:async';

import 'package:bmi/screens/add_record_screen.dart';
import 'package:bmi/screens/enter_information_screen.dart';
import 'package:bmi/screens/login_screen.dart';
import 'package:bmi/screens/main_screen.dart';
import 'package:bmi/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helpers/firebase_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget initialWidget = LoginScreen();
  try {
    var user = await FirebaseHelper.getInstance().UserId;
    print(user);
    if (user != null) {
      String status = await FirebaseHelper.getInstance().setUser();
      initialWidget = MainScreen();
      // initialWidget = AddRecordScreen();
    }
  } catch (e) {
    initialWidget = LoginScreen();
  }
  runApp(MyApp(initialWidget: initialWidget));
}

class MyApp extends StatelessWidget {
  MyApp({this.initialWidget, Key key}) : super(key: key);
  Widget initialWidget;
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'BMI Calculator',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const EnterInformationScreen(),
    // );
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ), //set desired text scale factor here
          child: child,
        );
      },
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: initialWidget,
    );
  }
}
