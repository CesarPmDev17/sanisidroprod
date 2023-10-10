import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPlaceData {
  final String? title;
  final String? address;
  final LatLng latlng;
  final String? img;

  MapPlaceData({this.title, this.address, required this.latlng, this.img});
}
