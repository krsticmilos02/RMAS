import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/screens/add_question_screen.dart';
import '../dashboard/profile/profile_screen.dart';
import '../repository/authentication_repository/authentication_repository.dart';
import '../screens/google_maps_screen.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({
    this.isMap = false
  });

  bool isMap;

  @override
  Widget build(BuildContext context) {
    return isMap ? MapBottomNavWidget() : GlobalBottomNavWidget();
  }
}

class GlobalBottomNavWidget extends StatelessWidget {
  const GlobalBottomNavWidget({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                Get.to(ProfileScreen());
              },
              icon: Icon(FontAwesomeIcons.userPen),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.blue.shade900,
            ),
            child: TextButton(
              onPressed: () {
                Get.to(()=> GoogleMapsScreen()) ;
              },
              child: Text('TO MAPS', style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
            ),
          ),
        ],
      ),
    );

  }
}

class MapBottomNavWidget extends StatelessWidget {
  const MapBottomNavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 270,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(FontAwesomeIcons.arrowLeftLong),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {
                Get.to(()=>AddQuestionScreen());
              },
              icon: Icon(Icons.add_rounded),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {
                Get.to(ProfileScreen());
              },
              icon: Icon(FontAwesomeIcons.userPen),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white.withOpacity(0.6),
            ),
            child: IconButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
            ),
          ),
        ],
      ),
    );
  }
}

