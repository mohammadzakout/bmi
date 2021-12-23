import 'package:bmi/models/bmi_record.dart';
import 'package:bmi/models/food_model.dart';
import 'package:bmi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseHelper {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String foodId = "";
  static BmiAppUser currentUser;
  static FirebaseHelper shared;
  static FirebaseHelper getInstance() {
    if (shared == null) {
      shared = FirebaseHelper();
    }
    return shared;
  }

  void setEditFoodDocId(String foodId) {
    this.foodId = foodId;
  }

  Stream<QuerySnapshot> recordsStream() async* {
    yield* _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("BMIRecords")
        .snapshots();
  }

  void deleteDoc(String id) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("Foods")
        .doc(id)
        .delete();
  }

  Stream<QuerySnapshot> foodStream() async* {
    yield* _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("Foods")
        .snapshots();
  }

  String get UserId {
    return _auth.currentUser.uid;
  }

  Future logIn(String email, String password) async {
    String result = "";

    print(email);
    print(password);
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => result = null);
      print(userCredential);
      await setUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'هذه المستخدم غير موجود';
      } else if (e.code == 'wrong-password') {
        result = 'خطأ في كلمة المرور';
      }
    } catch (e) {
      result = 'حصل خطأ حاول مجدداً';
    }
    print(result);
    return result;
  }

  Future<String> registerAndSave(BmiAppUser user, String password) async {
    String result;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      currentUser = user;

      await saveData();

      // save user data()

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = 'كلمة السر ضعيفة';
      } else if (e.code == 'email-already-in-use') {
        result = 'هذا البريد مسجل من قبل';

        print('1');
      }
    } catch (e) {
      result = 'حصل خطأ حاول مجدداً';
    }

    return result;
  }

  Future saveData() async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .set(currentUser.toJson());
  }

  void setInformation({String gender, int height, int weight, String dof}) {
    currentUser.gender = gender;
    currentUser.height = height;
    currentUser.weight = weight;
    currentUser.dateOfBirth = dof;
  }

  Future updateData() async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .set(currentUser.toJson());
  }

  Future addRecord(BmiRecord bmiRecord) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("BMIRecords")
        .add(bmiRecord.toJson());
  }

  Future addFood(Food food) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("Foods")
        .add(food.toJson());
  }

  Future editFood(Food food) async {
    await _firestore
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("Foods")
        .doc(foodId)
        .set(food.toJson());
  }

  // Future getRecord(BmiRecord bmiRecord) async {
  //   await _firestore
  //       .collection("User")
  //       .doc(_auth.currentUser.uid)
  //       .collection("BMIRecords")
  //       .get();
  // }

  Future<String> setUser() async {
    DocumentSnapshot q =
        await _firestore.collection('Users').doc(_auth.currentUser.uid).get();

    Map userMap = q.data();
    var user = BmiAppUser.fromJson(userMap);
    currentUser = user;
  }

  Future signOut() async {
    await _auth.signOut();
    currentUser = null;
  }
}
