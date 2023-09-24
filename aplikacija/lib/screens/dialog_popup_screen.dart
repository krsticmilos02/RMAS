import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/screens/my_questions_screen.dart';

import 'add_existing_or_new_screen.dart';

class DialogPopup extends StatelessWidget {
  late LatLng tappedPosition;

  DialogPopup({required this.tappedPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Would you like to add a question to your current location?", textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        //Get.to(()=>MyQuestionsScreen(tappedPosition: tappedPosition));
                        Get.to(() => AddNewOrExistingScreen(tappedPosition: tappedPosition,));
                      },
                      child: Text('YES'),
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Get.back();
                      },
                      child: Text('NO'),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
