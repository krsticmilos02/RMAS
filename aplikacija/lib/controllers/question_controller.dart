import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/repository/question_repository/question_repository.dart';

class QuestionController extends GetxController {
  static QuestionController get instance => Get.find();

  final theQuestion = TextEditingController();
  final answerA = TextEditingController();
  final answerB = TextEditingController();
  final answerC = TextEditingController();
  final answerD = TextEditingController();

  final questionRepo = Get.put(QuestionRepo());

  //uradjeno TODO logika za dodavanja pitanja u firebase bazu a pitanja korisniku

  Future<void> addQuestion(QuestionModel question) async {
    await questionRepo.addQuestionToUser(question);
    print(question);
  }

  // Get all User's questions

  Future<List<QuestionModel>> getAllUserQuestions() async {
    return await questionRepo.getAllMyQuestions();
  }
}