import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/modules/lugares/ruta/lugares_ruta_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LugaresDetalleController extends GetxController {
  late LugaresDetalleController _self;

  // Mapa
  bool existsPosition = true;
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-12.0640607, -77.0521935),
    zoom: 11.75,
  );
  final _mapController = Completer<GoogleMapController>();
  EdgeInsets mapInsetPadding = EdgeInsets.all(0.0);

  final delayingMap = true.obs;
  final showOverlayLoadingMap = true.obs;

  final gbOnlyMap = 'gbOnlyMap';

  // Data
  Lugar? lugarData;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is LugaresDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as LugaresDetalleArguments;
    lugarData = arguments.lugar;
    _loadMap();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }

    hideOverlayLoadingMap();
  }

  Future<void> _loadMap() async {
    initialPosition = CameraPosition(
      target: LatLng(lugarData!.numLatitud, lugarData!.numLongitud),
      zoom: 17.0,
    );
    await Helpers.sleep(600);
    if (_self.isClosed) return;
    delayingMap.value = false;
  }

  Future<void> hideOverlayLoadingMap() async {
    await Helpers.sleep(600);
    if (_self.isClosed) return;
    showOverlayLoadingMap.value = false;
  }

  Future<void> onComoLlegarTap() async {
    Get.toNamed(AppRoutes.LUGARES_RUTA,
        arguments: LugaresRutaArguments(lugar: lugarData!));
  }
}

class LugaresDetalleArguments {
  final Lugar lugar;

  LugaresDetalleArguments({required this.lugar});
}
