import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz_city_rmas/widgets/bottom_nav_widget.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController;
  List myQuestions = [];
  var searchAddr;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: deviceHeight,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  GoogleMap(
                    onMapCreated: onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(43.3209, 21.8958), zoom: 14.0),
                    markers: Set.from(myQuestions),
                    onTap: _setQuestion,
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
                              searchAndNavigate();
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
                    isMap: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setQuestion(LatLng tappedPosition){
    setState(() {
      myQuestions = [];
      myQuestions.add(
          Marker(
                  markerId: MarkerId(tappedPosition.toString()),
                  position: tappedPosition,
                  consumeTapEvents: true,
                  onTap: () => print("marker na poziciji $tappedPosition"),
            )
        //   GestureDetector(
        //     onTap: (){print("Tapped marker on position: $tappedPosition");},
        //     child: Marker(
        //       markerId: MarkerId(tappedPosition.toString()),
        //       position: tappedPosition,
        // ) as Widget,

      );
    });
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

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
