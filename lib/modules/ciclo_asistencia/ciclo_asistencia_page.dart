import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CicloAsistenciaPage extends StatelessWidget {
  final data = [
    MapPlaceData(
      title: '1 . Estación de Ciclo Asistencia',
      address: 'Av. Augusto Pérez Aranibar / av. Salaverry (ex parque la Pera)',
      latlng: LatLng(-12.10348409776234, -77.05862232673877),
    ),
    MapPlaceData(
      title: '2. Estación de Ciclo Asistencia',
      address: 'Puente de la Amistad',
      latlng: LatLng(-12.10968000232397, -77.05326609888154),
    ),
    MapPlaceData(
      title: '3.  Estación de Ciclo Asistencia',
      address: 'Plaza Constancio Bollar',
      latlng: LatLng(-12.09355244229553, -77.03321884999407),
    ),
    MapPlaceData(
      title: '4. Estación de Ciclo Asistencia',
      address: 'Av. Arequipa / av. Juan de Arona (berma central)',
      latlng: LatLng(-12.09701597293859, -77.03269365144486),
    ),
    MapPlaceData(
      title: '5. Estación de Ciclo Asistencia',
      address: 'Av. Arequipa / Av. Andrés Aramburú (berma central)',
      latlng: LatLng(-12.10339548591914, -77.03163277414308),
    ),
    MapPlaceData(
      title: '6. Estación de Ciclo Asistencia',
      address: 'Ca. Andrés Reyes Cdra. 5 (frente al parque Cáceres)',
      latlng: LatLng(-12.09296010355045, -77.02527503595019),
    ),
    MapPlaceData(
      title: '7. Estación de Ciclo Asistencia',
      address: 'Av. República de Panamá / Ca. Miguel Seminario (berma central)',
      latlng: LatLng(-12.09489163098208, -77.02152718836061),
    ),
    MapPlaceData(
      title: '8. Estación de Ciclo Asistencia',
      address:
          'Av. República de Panamá / av. Andrés Aramburu (frente a la caseta de serenazgo)',
      latlng: LatLng(-12.10128000555157, -77.01893857470597),
    ),
    MapPlaceData(
      title: '9. Estación de Ciclo Asistencia',
      address:
          'Av. Parque Sur / Av. José Galvez Barrenechea (al costado de la caseta de serenazgo)',
      latlng: LatLng(-12.10349390358163, -77.01145265016042),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Ciclo',
      subTitle: 'ASISTENCIA',
      mapName: 'Ubicaciones',
      places: data,
    );
  }
}
