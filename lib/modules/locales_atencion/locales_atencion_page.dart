import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalesAtencionPage extends StatelessWidget {
  final data = [
    MapPlaceData(
      title: 'Plataforma de Atención al Vecino',
      address: 'Calle 21 N° 765',
      latlng: LatLng(-12.09720755581001, -77.01481442528952),
    ),
    MapPlaceData(
      title: 'Plataforma de Atención al Vecino',
      address: 'Calle Augusto Tamayo N° 180',
      latlng: LatLng(-12.09759575688623, -77.02690983898192),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Locales',
      subTitle: 'DE ATENCIÓN',
      mapName: 'Ubicaciones',
      places: data,
    );
  }
}
