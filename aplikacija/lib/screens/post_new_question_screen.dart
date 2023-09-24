import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/controllers/profile_controller.dart';
import 'package:quiz_city_rmas/controllers/question_controller.dart';
import 'package:quiz_city_rmas/repository/question_repository/global_questions_repository.dart';

import '../authentication/models/user_model.dart';
import '../repository/question_repository/question_repository.dart';

enum AnswerEnum {
  A,
  B,
  C,
  D,
}

class PostNewQuestionScreen extends StatefulWidget {

  late LatLng tappedPosition;

  PostNewQuestionScreen({required this.tappedPosition});


  @override
  State<PostNewQuestionScreen> createState() => _PostNewQuestionScreenState(currentPosition: tappedPosition);
}

class _PostNewQuestionScreenState extends State<PostNewQuestionScreen> {
  AnswerEnum? _correctAnswer = AnswerEnum.A;
  final _formKeyValue = GlobalKey<FormState>();
  final controller = Get.put(QuestionController());
  final globalRepo = Get.put(GlobalQuestionRepo());
  final questionRepo = Get.put(QuestionRepo());
  late LatLng currentPosition;
  final profileController = Get.put(ProfileController());

  _PostNewQuestionScreenState({required this.currentPosition});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add a new question'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKeyValue,
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            TextFormField(
              controller: controller.theQuestion,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.question),
                border: OutlineInputBorder(),
                label: Text('Question'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.answerA,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.a),
                border: OutlineInputBorder(),
                label: Text('Possible answer'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.answerB,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.b),
                border: OutlineInputBorder(),
                label: Text('Possible answer'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.answerC,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.c),
                border: OutlineInputBorder(),
                label: Text('Possible answer'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.answerD,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.d),
                border: OutlineInputBorder(),
                label: Text('Possible answer'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select the correct answer from above',
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<AnswerEnum>(
                          title: Text('A'),
                          value: AnswerEnum.A,
                          groupValue: _correctAnswer,
                          onChanged: (val) {
                            setState(() {
                              _correctAnswer = val;
                            });
                          }),
                    ),
                    Expanded(
                        child: RadioListTile<AnswerEnum>(
                            title: Text('B'),
                            value: AnswerEnum.B,
                            groupValue: _correctAnswer,
                            onChanged: (val) {
                              setState(() {
                                _correctAnswer = val;
                              });
                            })),
                    Expanded(
                        child: RadioListTile<AnswerEnum>(
                            title: Text('C'),
                            value: AnswerEnum.C,
                            groupValue: _correctAnswer,
                            onChanged: (val) {
                              setState(() {
                                _correctAnswer = val;
                              });
                            })),
                    Expanded(
                        child: RadioListTile<AnswerEnum>(
                            title: Text('D'),
                            value: AnswerEnum.D,
                            groupValue: _correctAnswer,
                            onChanged: (val) {
                              setState(() {
                                _correctAnswer = val;
                              });
                            })),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      final question = QuestionModel(
                          theQuestion: controller.theQuestion.text.trim(),
                          answerA: controller.answerA.text.trim(),
                          answerB: controller.answerB.text.trim(),
                          answerC: controller.answerC.text.trim(),
                          answerD: controller.answerD.text.trim(),
                          correctAnswer: _correctAnswer?.name);


                      globalRepo.createGlobalQuestion(
                          question, currentPosition);
                      UserModel userData = questionRepo.user;

                      final updateUserData = UserModel(
                        id: userData.id,
                        email: userData.email,
                        username: userData.username,
                        fullName: userData.fullName,
                        password: userData.password,
                        phoneNo: userData.phoneNo,
                        profilePic: userData.profilePic,
                        numOfPostedQuestions: userData.numOfPostedQuestions + 1,
                        numOfPoints: userData.numOfPoints,
                        numOfAnsweredQuestions: userData.numOfAnsweredQuestions,
                      );

                      profileController.updateRecord(updateUserData);
                      
                      Future.delayed(Duration(seconds: 3), (){
                        Get.back(closeOverlays: true);
                      });
                    },
                    child: Text('POST'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
