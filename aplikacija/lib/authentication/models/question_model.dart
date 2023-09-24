import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionModel {
  final String? id;
  final String? theQuestion;
  final String? answerA;
  final String? answerB;
  final String? answerC;

  final String? answerD;
  final String? correctAnswer;

  const QuestionModel({
    this.id,
    required this.theQuestion,
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.correctAnswer,
  });

  toJson() {
    return {
      "TheQuestion": theQuestion,
      "AnswerA": answerA,
      "AnswerB": answerB,
      "AnswerC": answerC,
      "AnswerD": answerD,
      "CorrectAnswer": correctAnswer
    };
  }

  factory QuestionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return QuestionModel(
        id: document.id,
        theQuestion: data["TheQuestion"],
        answerA: data["AnswerA"],
        answerB: data["AnswerB"],
        answerC: data["AnswerC"],
        answerD: data["AnswerD"],
        correctAnswer: data["CorrectAnswer"]
    );
  }
}
