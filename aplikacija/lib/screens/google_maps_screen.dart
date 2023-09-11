import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:quiz_city_rmas/authentication/models/global_question_model.dart';
import 'package:quiz_city_rmas/repository/question_repository/global_questions_repository.dart';
import 'package:quiz_city_rmas/repository/question_repository/question_repository.dart';
import 'package:quiz_city_rmas/screens/dialog_popup_screen.dart';
import 'package:quiz_city_rmas/screens/my_questions_screen.dart';
import 'package:quiz_city_rmas/screens/quiz_question_screen.dart';
import 'package:quiz_city_rmas/widgets/bottom_nav_widget.dart';
import 'package:quiz_city_rmas/widgets/question_marker_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsScreen extends StatefulWidget {

  GoogleMapsScreen();

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final loc.Location location = loc.Location();
  bool _added = false;
  var retrievedUserId;
  late BitmapDescriptor customIcon;
  late BitmapDescriptor currentUserIcon;
  late GoogleMapController mapController;
  final globalRepo = Get.put(GlobalQuestionRepo());
  final questionRepo = Get.put(QuestionRepo());
  late Position position;

  Timer? timer;
  List allQuestions = [];

  //TODO povezi sa bazom da se ovo inicijalizuje iz firebase-a
  var searchAddr;

  void initState() {
    _retrieveUserId();
    _initGlobalQuestions();
    _requestPermission();
    _setCustomIcon();
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => _updateCurrLoc());
    _initGlobalQuestions();
    super.initState();
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          height: deviceHeight,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) async {
                  setState(() {
                    mapController = controller;
                    _added = true;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(43.32472, 21.90333),
                    zoom: 14.47),
                markers: Set.from(allQuestions),
                //TODO promeni na allQuestions kada napravis iznad
                onTap: _setMarker,
              ),
              Positioned(
                top: 50.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter location name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 20.0,
                        top: 15.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(FontAwesomeIcons.magnifyingGlass),
                        color: Colors.blue,
                        onPressed: () => setState(() {
                          _printAllQuestions();
                          // searchAndNavigate(); TODO vrati nazad da ovo radi samo odkomentarisi
                        }),
                        iconSize: 30.0,
                        padding: EdgeInsets.only(right: 20.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                ),
              ),
              BottomNavWidget(
                isMap: true,)
            ],
          ),
        ),
    );
  }


  _setCustomIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
            'images/questionMarkerIcon128.png')
        .then((d) {
      customIcon = d;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
            'images/currentLocationMarker64.png')
        .then((d) {
      currentUserIcon = d;
    });
  }

  _tappedMarker(String? theQuestion, String? answerA, String? answerB,
      String? answerC, String? answerD, String? correctAnswer) {
    Get.to(() => QuizQuestionScreen(
        theQuestion: theQuestion!,
        answerA: answerA!,
        answerB: answerB!,
        answerC: answerC!,
        answerD: answerD!,
        correctAnswer: correctAnswer!));
  }

  _printAllQuestions()
  {
    for(int i = 0; i < allQuestions.length; i++)
      {
        print("$allQuestions[i]");
      }
  }

  _initGlobalQuestions() {
    allQuestions = [];
    globalRepo.getGlobalQuestions().then((value) {
      for (var i = 1; i <= value.length; i++) {
        allQuestions.add(QuestionMarker(
            markerId: MarkerId(value[i].theQuestion!),
            position: LatLng(value[i].tappedLat, value[i].tappedLng),
            onTap: () {
              _tappedMarker(
                  value[i].theQuestion,
                  value[i].answerA,
                  value[i].answerB,
                  value[i].answerC,
                  value[i].answerD,
                  value[i].correctAnswer);
            },
            consumeTapEvents: true,
            icon: customIcon));
      }
      setState(() {});
    });
  }

  _retrieveUserId() {
    retrievedUserId = questionRepo.findUser();
  }

  _setMarker(LatLng tappedPosition) {
    Get.to(() => DialogPopup(tappedPosition: tappedPosition));
  }

  searchAndNavigate() {
    locationFromAddress(searchAddr).then((result) {
      print(result[0].latitude);
      print(result[0].longitude);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(result[0].latitude, result[0].longitude),
            zoom: 17.0,
          ),
        ),
      );
    });
  }

  _getCurrLoc() async{

    return position;
  }

  _updateCurrLoc() async{
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    allQuestions[0] = Marker(markerId: MarkerId("currentLoc"),
      position: LatLng(position.latitude, position.longitude),
      icon: currentUserIcon,
      consumeTapEvents: true,
    );

    setState(() {

    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if(status.isGranted) {
      print("done");
    } else if(status.isDenied) {
      _requestPermission();
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
