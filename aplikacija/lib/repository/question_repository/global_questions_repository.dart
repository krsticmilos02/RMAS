import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz_city_rmas/authentication/models/global_question_model.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/repository/user_repository/user_repository.dart';

import '../../authentication/models/user_model.dart';

class GlobalQuestionRepo extends GetxController {

  static GlobalQuestionRepo get instance => Get.find();

  final userRepo = Get.put(UserRepository());
  final _db = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  addQuestionToGlobalList(GlobalQuestionModel question) async {
    await _db.collection("Questions").add(question.toJson()).whenComplete(
          () =>
          Get.snackbar("Success", "Your question has been created!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }

  bool hasAlreadyAnswered(String questionId){
    var hasAnswered;

    findUser(questionId).then((value) {
      hasAnswered = value;
    });

    return hasAnswered;
  }

  Future<bool> findUser(String questionId) async{

    var userData;

    await userRepo.getUserDetails(firebaseUser!.email!).then((value) {
      userData = value;
    });

    final snapshot = await _db.collection("Questions").doc(questionId).collection("UsersThatAnswered").where("UserId", isEqualTo: userData.id).get();


    
    return snapshot.docs.isEmpty;
  }

  Future<List<GlobalQuestionModel>> getGlobalQuestions() async {
    final snapshot = await _db.collection("Questions").get();
    final listOfQuestions = snapshot.docs.map((e) =>
        GlobalQuestionModel.fromSnapshot(e)).toList();
    return listOfQuestions;
  }

  addUserToQuestion(String userId, String questionId) async {
    await _db.collection("Questions").doc(questionId).collection("UsersThatAnswered").add(
        {"UserId": userId}).whenComplete(
        () => printInfo(info: "Success")).catchError((error, stackTrace){
       printInfo(info: "Failed");
    });
  }

  createGlobalQuestion(QuestionModel question, LatLng tappedPosition) {
    GlobalQuestionModel globalQuestion = GlobalQuestionModel(
        tappedLat: tappedPosition.latitude,
        tappedLng: tappedPosition.longitude,
        theQuestion: question.theQuestion,
        answerA: question.answerA,
        answerB: question.answerB,
        answerC: question.answerC,
        answerD: question.answerD,
        correctAnswer: question.correctAnswer);

    addQuestionToGlobalList(globalQuestion);
  }
}
