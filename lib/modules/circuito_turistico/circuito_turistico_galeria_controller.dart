import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/circuito_turistico/circuito_turistico_mapa_page.dart';
import 'package:app_san_isidro/modules/circuito_turistico/widgets/description_widget.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CircuitoTuristicoGaleriaController extends GetxController {
  late BuildContext _context;

  final data = [
    MapPlaceData(
      title: 'Centro Cultural El Olivar de San Isidro',
      img: 'https://i.imgur.com/WsJggTO.jpeg',
      latlng: LatLng(-12.10147, -77.03575),
    ),
    MapPlaceData(
      title: 'Biblioteca Infantil de la Municipalidad de San Isidro',
      img: 'https://i.imgur.com/QT1FV5E.jpeg',
      latlng: LatLng(-12.10143, -77.03571),
    ),
    MapPlaceData(
      title: 'Palacio Municipal y de la Cultura',
      img: 'https://i.imgur.com/LoqTIIa.jpeg',
      latlng: LatLng(-12.09912, -77.03467),
    ),
    MapPlaceData(
      title: 'Casa Museo Marina Núñez Del Prado',
      img: 'https://i.imgur.com/bzpy6ny.jpeg',
      latlng: LatLng(-12.10093, -77.03376),
    ),
    MapPlaceData(
      title: 'Olivo Histórico',
      img: 'https://i.imgur.com/sXfCvlM.jpeg',
      latlng: LatLng(-12.10079, -77.03419),
    ),
    MapPlaceData(
      title: 'Laguna de El Olivar',
      img: 'https://i.imgur.com/ypCgC5m.jpeg',
      latlng: LatLng(-12.10197, -77.03555),
    ),
    MapPlaceData(
      title: 'Laguna de Novios',
      img: 'https://i.imgur.com/POZstIw.jpeg',
      latlng: LatLng(-12.09867, -77.03466),
    ),
    MapPlaceData(
      title: 'Prensa de Olivos',
      img: 'https://i.imgur.com/vOm2KL2.jpeg',
      latlng: LatLng(-12.09885, -77.03454),
    ),
    MapPlaceData(
      title: 'Museo de Sitio Huallamarca',
      img: 'https://i.imgur.com/xY7M9wH.jpeg',
      latlng: LatLng(-12.09732, -77.04044),
    ),
    MapPlaceData(
      title: 'Ginsberg Galeria',
      img: 'https://i.imgur.com/XOVNL75.jpeg',
      latlng: LatLng(-12.10701, -77.03831),
    ),
    MapPlaceData(
      title: 'Galeria Enlace Arte Contemporaneo',
      img: 'https://i.imgur.com/7ReQDXb.jpeg',
      latlng: LatLng(-12.10547, -77.03885),
    ),
    MapPlaceData(
      title: 'Centro Cultural PUCP',
      img: 'https://i.imgur.com/nM38TXe.jpeg',
      latlng: LatLng(-12.10459, -77.03872),
    ),
    MapPlaceData(
      title: 'La Galería - Arte Contemporáneo',
      img: 'https://i.imgur.com/TxK4SBs.jpeg',
      latlng: LatLng(-12.10308, -77.03731),
    ),
    MapPlaceData(
      title: 'Tessor Art & Design',
      img: 'https://i.imgur.com/hlt16Gw.jpeg',
      latlng: LatLng(-12.10115, -77.03618),
    ),
    MapPlaceData(
      title: 'Galería Oleos Peruanos',
      img: 'https://i.imgur.com/GNsVpB4.jpeg',
      latlng: LatLng(-12.09748, -77.03748),
    ),
    MapPlaceData(
      title: 'Proyecto AMIL',
      img: 'https://i.imgur.com/srzJSK4.jpeg',
      latlng: LatLng(-12.09656, -77.03607),
    ),
    MapPlaceData(
      title: 'Indigo Arte y Artesanía',
      img: 'https://i.imgur.com/ekZ4aey.jpeg',
      latlng: LatLng(-12.09488, -77.03378),
    ),
    MapPlaceData(
      title: 'Atípico arte + diseño',
      img: 'https://i.imgur.com/2HPa7nO.jpeg',
      latlng: LatLng(-12.09489, -77.03366),
    ),
    MapPlaceData(
      title: 'Revolver Galería',
      img: 'https://i.imgur.com/JrDznVo.jpeg',
      latlng: LatLng(-12.09515, -77.03363),
    ),
    MapPlaceData(
      title: 'Centro Cultural Cafae',
      img: 'https://i.imgur.com/mEyHlu0.png',
      latlng: LatLng(-12.09522, -77.03264),
    ),
    MapPlaceData(
      title: 'A3 Espacio',
      img: 'https://i.imgur.com/wgGYX60.jpeg',
      latlng: LatLng(-12.10035, -77.03297),
    ),
    MapPlaceData(
      title: 'Parroquia Nuestra Señora del Pilar',
      img: 'https://i.imgur.com/ohvkoe2.jpeg',
      latlng: LatLng(-12.09626, -77.03585),
    ),
    MapPlaceData(
      title: 'Replica de la Piedra de Saywite',
      img: 'https://i.imgur.com/gXI3qOz.jpeg',
      latlng: LatLng(-12.10362, -77.03884),
    ),
  ];

  Color get barrierColor => Colors.black.withOpacity(.45);

  @override
  void onInit() {
    super.onInit();
  }

  void setContext(BuildContext _c) {
    this._context = _c;
  }

  Future<void> onItemTap(int index, MapPlaceData selectItem) async {
    await showBarModalBottomSheet(
      expand: false,
      context: _context,
      barrierColor: barrierColor,
      topControl: ModalTop(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      builder: (context) => DescriptionWidget(
        item: selectItem,
        onVerMasTap: () {
          _onVerMapaTap(index, selectItem);
        },
      ),
    );
  }

  Future<void> _onVerMapaTap(int index, MapPlaceData selectItem) async {
    Get.back();
    await Helpers.sleep(400);
    Get.toNamed(
      AppRoutes.CIRCUITO_TURISTICO_MAPA,
      arguments: CircuitoTuristicoMapaArguments(
        data: data,
        indexSelected: index,
      ),
    );
  }
}
