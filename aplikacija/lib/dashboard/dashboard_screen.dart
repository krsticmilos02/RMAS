import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/repository/question_repository/question_repository.dart';
import '../authentication/models/user_model.dart';
import '../widgets/bottom_nav_widget.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';


class DashboardTest extends StatefulWidget {
  const DashboardTest({super.key});

  @override
  State<DashboardTest> createState() => _DashboardTestState();
}

class _DashboardTestState extends State<DashboardTest> {

  var retrievedUserId;
  final questionRepo = Get.put(QuestionRepo());
  final loc.Location initLocation = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubsription;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());

    var _fullName;
    var _username;

    initState(){
      _requestPermission();
      _getLocation();
      _retrieveUserId();
      super.initState();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Quiz City'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel initUserData = snapshot.data as UserModel;
                        _fullName = initUserData.fullName;
                        _username = initUserData.username;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(_fullName),
                            Text(_username),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text("Stats:"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(TextSpan(
                                    text: '# Answered Questions: ',
                                    children: [TextSpan(text: 'TODO')])),
                                Text.rich(TextSpan(
                                    text: '# Points: ',
                                    children: [TextSpan(text: 'TODO')])),
                                Text.rich(TextSpan(
                                    text: '# Posted Questions: ',
                                    children: [TextSpan(text: 'TODO')])),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  //TODO: go to leaderboards page
                                },
                                child: Text('LEADERBOARDS'),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),

            BottomNavWidget(isMap: false,),
          ],
        ),
      ),
    );
  }
  _retrieveUserId()
  {
    retrievedUserId = questionRepo.findUser();
  }

  _getLocation() async{
    try{
      final loc.LocationData _locationResult = await initLocation.getLocation();
      await FirebaseFirestore.instance.collection("Users").doc(retrievedUserId).collection("LastLocation").doc("loc").set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
      }, SetOptions(merge: true));
    }catch(e){
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    var retrievedUserId = questionRepo.findUser();
    _locationSubsription = initLocation.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubsription?.cancel();
      setState(() {
        _locationSubsription = null;
      });
    }).listen((loc.LocationData currentLocation) async {
      await FirebaseFirestore.instance.collection("Users").doc(retrievedUserId).collection("LastLocation").doc("loc").set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude
      }, SetOptions(merge: true));
    });
  }

  _requestPermission() async{
    var status = await Permission.location.request();
    if (status.isGranted){
      print('done');
    } else if(status.isDenied){
      _requestPermission();
    } else if(status.isPermanentlyDenied){
      openAppSettings();
    }
  }
}

