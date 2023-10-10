import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PuntosRecreacionPage extends StatelessWidget {
  final List<MapPlaceData> data = [
    MapPlaceData(
      title: 'Complejo Deportivo Municipal',
      latlng: LatLng(-12.10758111465556, -77.05424194812528),
      address: 'Av. Augusto Pérez Araníbar 1595',
      img: 'https://i.imgur.com/Jt9jq2u.png',
    ),
    MapPlaceData(
      title: 'Gimnasio al aire libre "Plaza 31"',
      latlng: LatLng(-12.10048263402125, -77.01795711201277),
      img: 'https://i.imgur.com/gZCITNZ.png',
    ),
    MapPlaceData(
      title: 'Parque Bicentenario San Isidro',
      latlng: LatLng(-12.10905612967779, -77.05505151945985),
      img: 'https://i.imgur.com/swCQRAi.jpeg',
    ),
    MapPlaceData(
      title: 'CEV Corpac - Centro de Encuentro Vecinal',
      latlng: LatLng(-12.10032667602002, -77.01279742075269),
      address: 'Calle Orden y Libertad 119',
      img: 'https://i.imgur.com/0SZ2yR1.png',
    ),
    MapPlaceData(
      title: 'CEV Los Halcones - Centro de Encuentro Vecinal',
      latlng: LatLng(-12.09953989702001, -77.02060206995642),
      address: 'C. Los Halcones 234, San Isidro 15036',
      img: 'https://i.imgur.com/ThiEzuJ.png',
    ),
    MapPlaceData(
      title: 'CEV JUAN POLAR - Centro de Encuentro Vecinal',
      latlng: LatLng(-12.0956957387985, -77.05711640272423),
      address: 'LIMA, Calle Juan Manuel Polar 105, San Isidro',
      img: 'https://i.imgur.com/cVYSG8w.jpeg',
    ),
    MapPlaceData(
      title: 'CEV Santa Cruz - Centro de Encuentro Vecinal',
      latlng: LatLng(-12.10562961220872, -77.04847404251291),
      address: 'Tnte. Coronel Paul de Beaudiez V, 27, San Isidro 15076',
      img: 'https://i.imgur.com/Ty8FHV3.png',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Malecón Bernales',
      latlng: LatLng(-12.10715625370208, -77.05725354654747),
      img: 'https://i.imgur.com/5WWCiti.png',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque Alfonso Ugarte',
      latlng: LatLng(-12.09529366903061, -77.0490847598674),
      img: 'https://i.imgur.com/07uj5u4.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque José Luis Bustamante y Rivero',
      latlng: LatLng(-12.10086389388183, -77.0224364753464),
      img: 'https://i.imgur.com/RcLLVss.jpeg',
    ),
    MapPlaceData(
      title: 'Juegos Infantiles - Parque José Luis Bustamante y Rivero',
      latlng: LatLng(-12.10033547964943, -77.02271239805893),
      img: 'https://i.imgur.com/0tOTbEE.jpeg',
    ),
    MapPlaceData(
      title: 'Juegos Infantiles - Parque Fray Melchor Talamantes',
      latlng: LatLng(-12.09322839485618, -77.01473020773831),
      img: 'https://i.imgur.com/Dh5O02M.jpeg',
    ),
    MapPlaceData(
      title: 'Juegos Infantiles - Parque Dignidad',
      latlng: LatLng(-12.09060770989785, -77.01141177706741),
      img: 'https://i.imgur.com/xSvgVgB.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque Dignidad',
      latlng: LatLng(-12.09033173413597, -77.01110828112138),
      img: 'https://i.imgur.com/oyEjPBd.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque Norte',
      latlng: LatLng(-12.09243127095498, -77.01091436717468),
      img: 'https://i.imgur.com/RVpvZop.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque Sur',
      latlng: LatLng(-12.10401665844298, -77.01363417128019),
      img: 'https://i.imgur.com/OuZYG8W.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - Parque San Martin de Porres',
      latlng: LatLng(-12.09429162125787, -77.01872844944556),
      img: 'https://i.imgur.com/z17ceOD.jpeg',
    ),
    MapPlaceData(
      title: 'Gimnasio al Aire Libre - El Golf',
      latlng: LatLng(-12.10233744727438, -77.05127701352313),
      img: 'https://i.imgur.com/Tu6Yws9.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Puntos de recreacion',
      subTitle: 'Y DEPORTES',
      mapName: 'Ubicaciones',
      places: data,
    );
  }
}
