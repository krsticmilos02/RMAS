import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/controllers/question_controller.dart';

enum AnswerEnum {
  A,
  B,
  C,
  D,
}

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  AnswerEnum? _correctAnswer = AnswerEnum.A;
  final _formKeyValue = GlobalKey<FormState>();
  final controller = Get.put(QuestionController());

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
                      if(_formKeyValue.currentState!.validate()){

                        final question = QuestionModel(
                            theQuestion: controller.theQuestion.text.trim(),
                            answerA: controller.answerA.text.trim(),
                            answerB: controller.answerB.text.trim(),
                            answerC: controller.answerC.text.trim(),
                            answerD: controller.answerD.text.trim(),
                            correctAnswer: _correctAnswer?.name);

                        QuestionController.instance.addQuestion(question);
                        Get.back();

                      }
                    },
                    child: Text('SAVE TO MY LIST'),
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
