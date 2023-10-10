import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PuntosEvacuacionPage extends StatelessWidget {
  final data = [
    MapPlaceData(
      title: '1.3',
      latlng: LatLng(-12.094278, -77.053949),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Puntos',
      subTitle: 'DE EVACUACION',
      mapName: 'Puntos de evacuacion',
      places: data,
    );
  }
}
