import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';

import '../../authentication/models/user_model.dart';

class QuestionRepo extends GetxController {
  static QuestionRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  late var retrievedUserId;
  late var questionList;
  late var userData; //TODO ispravi ako se pojebe nesto


  findUser() async{
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: firebaseUser?.email).get();

    userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    retrievedUserId = userData.id;

    return retrievedUserId;
  }

  addQuestionToUser(QuestionModel question) async {
    //await _db.collection("Users").doc(firebaseUser?.uid).collection("MyQuestions")
    await findUser();
    await _db.collection("Users").doc(retrievedUserId).collection("MyQuestions").add(question.toJson()).whenComplete(
          () =>
          Get.snackbar("Success", "Your account has been created!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  UserModel get user => userData;

  Future<List<QuestionModel>> getAllMyQuestions() async{
    await findUser();
    final snapshot = await _db.collection("Users").doc(retrievedUserId).collection("MyQuestions").get();
    final listOfQuestions = snapshot.docs.map((e) => QuestionModel.fromSnapshot(e)).toList();
    return listOfQuestions;
  }
}
