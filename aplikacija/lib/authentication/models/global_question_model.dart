import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';

class GlobalQuestionModel extends QuestionModel {
  final double tappedLat;
  final double tappedLng;
  final String? id;

  GlobalQuestionModel(
      {this.id,
      required this.tappedLat,
      required this.tappedLng,
      required super.theQuestion,
      required super.answerA,
      required super.answerB,
      required super.answerC,
      required super.answerD,
      required super.correctAnswer});

  toJson() {
    return {
      "TappedLat": tappedLat,
      "TappedLng": tappedLng,
      "TheQuestion": theQuestion,
      "AnswerA": answerA,
      "AnswerB": answerB,
      "AnswerC": answerC,
      "AnswerD": answerD,
      "CorrectAnswer": correctAnswer
    };
  }

  factory GlobalQuestionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return GlobalQuestionModel(
        id: document.id,
        theQuestion: data["TheQuestion"],
        answerA: data["AnswerA"],
        answerB: data["AnswerB"],
        answerC: data["AnswerC"],
        answerD: data["AnswerD"],
        correctAnswer: data["CorrectAnswer"],
        tappedLat: data["TappedLat"],
        tappedLng: data["TappedLng"]);
  }
}
