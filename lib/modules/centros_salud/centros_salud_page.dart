import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CentrosSaludPage extends StatelessWidget {
  final data = [
    MapPlaceData(
      title: 'Centro de Triaje',
      address: 'Calle Paul Harris N°205',
      latlng: LatLng(-12.10775297589603, -77.05023924510277),
    ),
    MapPlaceData(
      title: 'Policlínico Municipal',
      address: 'Calle Paul Harris N°205',
      latlng: LatLng(-12.10757114981925, -77.05059397217759),
    ),
    MapPlaceData(
      title: 'Centro de Salud San Isidro - MINSA',
      address: 'Av. Augusto Pérez Araníbar 1756, San Isidro 15076',
      latlng: LatLng(-12.10691386767708, -77.05513317283022),
      img: 'https://i.imgur.com/30Iz55Y.png',
    ),
    MapPlaceData(
      title: 'Centro de Atención Primaria San Isidro Essalud',
      address: 'Av. Augusto Pérez Araníbar 1551, San Isidro 15076',
      latlng: LatLng(-12.10852269339179, -77.05351843655473),
      img: 'https://i.imgur.com/30Iz55Y.png',
    ),
    MapPlaceData(
      title:
          'Centro de Vacunación Internacional del Ministerio de Salud de Perú',
      address: 'Av. Augusto Pérez Araníbar 1355',
      latlng: LatLng(-12.10747708450947, -77.05436536085074),
      img: 'https://i.imgur.com/30Iz55Y.png',
    ),
    MapPlaceData(
      title: 'Essalud Agencia de Seguros San Isidro',
      address: 'Av. Arequipa 2890, San Isidro 15073',
      latlng: LatLng(-12.09420785708985, -77.03325518809226),
      img: 'https://i.imgur.com/30Iz55Y.png',
    ),
    MapPlaceData(
      title: 'Clínica Internacional, Medicentro San Isidro',
      address: 'Av. P.º de la República 3058, San Isidro 15034',
      latlng: LatLng(-12.09311937884672, -77.02395584575508),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Clínica Javier Prado',
      address: 'Av. Javier Prado Este 499, San Isidro 15046',
      latlng: LatLng(-12.09133156046162, -77.02838344569635),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Centro Médico Clínica las Palmeras',
      address: 'Av Javier Prado Oeste 1465, San Isidro 15073',
      latlng: LatLng(-12.09432154510707, -77.04547403325958),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Clínica Ricardo Palma',
      address: 'Av. Javier Prado Este 1066, San Isidro 15036',
      latlng: LatLng(-12.09058202872024, -77.01831592727764),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Clinica El Olivar - San Isidro',
      address: 'Av. Arequipa 3184, San Isidro',
      latlng: LatLng(-12.09704257320146, -77.03280958925237),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Clínica Limatambo',
      address: 'Av. República de Panamá 3606, San Isidro 15047',
      latlng: LatLng(-12.10063219273946, -77.01938646313486),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'SANNA \ Clínica El Golf',
      address: 'Av. Aurelio Miró Quesada 1030, San Isidro 15073',
      latlng: LatLng(-12.09891684061725, -77.05137261178457),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Concebir - San Isidro',
      address: 'Calle Los Olivos 364, San Isidro 15073',
      latlng: LatLng(-12.09338875733556, -77.03544454028494),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'NovoClinic',
      address: 'Av. Gral. Salaverry 2665, San Isidro 15076',
      latlng: LatLng(-12.09394322987431, -77.05343998022128),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'FISIOSALUD - Centro de Rehabilitación y Fisioterapia',
      address: 'Av. José Galvez Barrenechea 148, San Isidro 15036',
      latlng: LatLng(-12.09101767686291, -77.01437034477506),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'MEDEX Medicina Externa S.A.',
      address: 'Av. República de Panamá 3065, San Isidro 15047',
      latlng: LatLng(-12.09423801053309, -77.02147454438347),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'Centro de Diagnóstico Integral San Isidro',
      address: 'Av. Guardia Civil 254, San Isidro 15036',
      latlng: LatLng(-12.09056724821904, -77.00838419615768),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
    MapPlaceData(
      title: 'COA Centro Odontológico Americano San Isidro',
      address: 'Av. Petit Thouars 3470, San Isidro 15046',
      latlng: LatLng(-12.09675989857168, -77.03157552864351),
      img: 'https://i.imgur.com/iUtDXVc.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Centros',
      subTitle: 'DE SALUD',
      mapName: 'Puntos de Salud',
      places: data,
    );
  }
}
