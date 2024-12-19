import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';

class GameMatch {
  final LatLng coordinates;
  final String mapillaryCode;

  GameMatch({required this.coordinates, required this.mapillaryCode}) {
    debugPrint(
        "CREATED MATCH: Lat=${coordinates.latitude}|Lon=${coordinates.longitude}|Code=$mapillaryCode");
  }
}
