import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QuestionMarker extends Marker{


  QuestionMarker({
    required super.markerId,
    required super.position,
    required super.onTap,
    required super.consumeTapEvents,
    super.icon,
  });

}