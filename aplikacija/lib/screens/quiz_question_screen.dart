import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/controllers/question_controller.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String theQuestion;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;

  QuizQuestionScreen(
      {required this.theQuestion,
      required this.answerA,
      required this.answerB,
      required this.answerC,
      required this.answerD,
      required this.correctAnswer});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState(
      theQuestion, answerA, answerB, answerC, answerD, correctAnswer);
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final String theQuestion;
  final String answerA;
  final String answerB;
  final String answerC;
  final String answerD;
  final String correctAnswer;

  _QuizQuestionScreenState(this.theQuestion, this.answerA, this.answerB,
      this.answerC, this.answerD, this.correctAnswer);

  @override
  Widget build(BuildContext context) {
    int numOfTries = 0;
    bool foundCorrectAnswer = false;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Answer this question to get points'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  theQuestion,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (correctAnswer == "A"){

                          }
                        },
                        child: Text(
                          "A: ${answerA}",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "B: ${answerB}",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "C: ${answerC}",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "D: ${answerD}",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          ),
        ));
  }
}
