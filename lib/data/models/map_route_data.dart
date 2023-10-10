import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouteData {
  final List<LatLng> points;
  final Color color;
  final int width;

  MapRouteData({
    required this.points,
    this.color = Colors.black,
    this.width = 4,
  });
}
