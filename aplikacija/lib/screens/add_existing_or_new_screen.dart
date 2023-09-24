import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/screens/add_question_screen.dart';
import 'package:quiz_city_rmas/screens/my_questions_screen.dart';
import 'package:quiz_city_rmas/screens/post_new_question_screen.dart';

class AddNewOrExistingScreen extends StatelessWidget {
  late LatLng tappedPosition;

  AddNewOrExistingScreen({required this.tappedPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(() => MyQuestionsScreen(tappedPosition: tappedPosition));
                  },
                  child: Text('EXISTING'),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(() => PostNewQuestionScreen(tappedPosition: tappedPosition,));
                  },
                  child: Text('NEW'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
