import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/screens/my_questions_screen.dart';

class DialogPopup extends StatelessWidget {
  late LatLng tappedPosition;

  DialogPopup({required this.tappedPosition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Would you like to set the question here?"),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      Get.to(()=>MyQuestionsScreen(tappedPosition: tappedPosition));
                    },
                    child: Text('YES'),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
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
    );
  }
}
