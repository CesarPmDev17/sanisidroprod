import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircuitoTuristicoMapaArguments {
  final List<MapPlaceData> data;
  final int? indexSelected;

  CircuitoTuristicoMapaArguments({required this.data, this.indexSelected});
}

class CircuitoTuristicoMapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Circuito',
      subTitle: 'TURÍSTICO',
      mapName: 'Turismo distrital',
      places: (Get.arguments as CircuitoTuristicoMapaArguments).data,
      placeIndexSelected:
          (Get.arguments as CircuitoTuristicoMapaArguments).indexSelected,
    );
  }
}
