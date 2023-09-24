import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/controllers/profile_controller.dart';
import 'package:quiz_city_rmas/controllers/question_controller.dart';
import 'package:quiz_city_rmas/repository/question_repository/global_questions_repository.dart';
import 'package:quiz_city_rmas/screens/google_maps_screen.dart';

import '../authentication/models/user_model.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String theQuestion;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;
  final String id;

  QuizQuestionScreen(
      {required this.id,
      required this.theQuestion,
      required this.answerA,
      required this.answerB,
      required this.answerC,
      required this.answerD,
      required this.correctAnswer});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState(
      id, theQuestion, answerA, answerB, answerC, answerD, correctAnswer);
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final String id;
  final String theQuestion;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;

  _QuizQuestionScreenState(this.id, this.theQuestion, this.answerA,
      this.answerB, this.answerC, this.answerD, this.correctAnswer);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    int numOfTries = 0;
    bool foundCorrectAnswer = false;
    bool pressedButton = false;
    final globalQuestionRepo = Get.put(GlobalQuestionRepo());

    processCorrectAnswer(String char, UserModel initUserData) {
      int points = 0;
      if (correctAnswer == char) {
        if (numOfTries > 2) {
          points = 1;
        } else if (numOfTries == 2) {
          points = 2;
        } else if (numOfTries == 1) {
          points = 5;
        } else if (numOfTries == 0) {
          points = 10;
        }

        // TODO
        final userData = UserModel(
          id: initUserData.id,
          email: initUserData.email,
          username: initUserData.username,
          fullName: initUserData.fullName,
          password: initUserData.password,
          phoneNo: initUserData.phoneNo,
          profilePic: initUserData.profilePic,
          numOfAnsweredQuestions: initUserData.numOfAnsweredQuestions + 1,
          numOfPoints: initUserData.numOfPoints + points,
          numOfPostedQuestions: initUserData.numOfPostedQuestions,
        );

        controller.updateRecord(userData);

        Get.snackbar("CORRECT",
            "Good job, you got the answer right and won ${points} points.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        globalQuestionRepo.addUserToQuestion(initUserData.id!, id);
        Future.delayed(Duration(seconds: 3), () {
          Get.back(closeOverlays: true);
        });
      } else {
        Get.snackbar("WRONG", "Try a different answer.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 1));
        numOfTries++;
      }
    }

    Future<UserModel> currUser = controller.getUserData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Answer this question to get points'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel initUserData = snapshot.data as UserModel;

                  return FutureBuilder(
                      future: globalQuestionRepo.findUser(id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            bool hasAnswered = snapshot.data as bool;

                            return hasAnswered
                                ? Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          theQuestion,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  processCorrectAnswer(
                                                      "A", initUserData);
                                                },
                                                child: Text(
                                                  "A: ${answerA}",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ))),
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {processCorrectAnswer(
                                                    "B", initUserData);
                                                },
                                                child: Text(
                                                  "B: ${answerB}",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ))),
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {processCorrectAnswer(
                                                    "C", initUserData);
                                                },
                                                child: Text(
                                                  "C: ${answerC}",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ))),
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {processCorrectAnswer(
                                                    "D", initUserData);
                                                },
                                                child: Text(
                                                  "D: ${answerD}",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ))),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                        "You already answered this question cowboy!"));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
