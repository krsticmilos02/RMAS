import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/authentication/models/question_model.dart';
import 'package:quiz_city_rmas/controllers/question_controller.dart';
import 'package:quiz_city_rmas/repository/question_repository/global_questions_repository.dart';
import 'package:quiz_city_rmas/screens/google_maps_screen.dart';

class MyQuestionsScreen extends StatelessWidget {
  late LatLng tappedPosition;

  MyQuestionsScreen({required this.tappedPosition});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());
    final globalRepo = Get.put(GlobalQuestionRepo());

    return Scaffold(
      appBar: AppBar(
        title: Text("My questions"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
            future: controller.getAllUserQuestions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<QuestionModel> questionData =
                      snapshot.data as List<QuestionModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              globalRepo.createGlobalQuestion(snapshot.data![index], tappedPosition);
                              //funkcija(QuestionModel snapshot.data![index], LatLng tappedPosition) i obradjuje i stavlja u bazu
                            },
                            child: ListTile(
                              iconColor: Colors.blue,
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: const Icon(FontAwesomeIcons.question),
                              title: Text(
                                "${snapshot.data![index].theQuestion}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
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
