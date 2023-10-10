import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VPSIDetalleController extends GetxController {
  // Instances
  late VPSIDetalleController _self;

  // Mapa
  bool existsPosition = true;
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(-12.0640607, -77.0521935),
    zoom: 11.75,
  );
  final _mapController = Completer<GoogleMapController>();
  EdgeInsets mapInsetPadding = EdgeInsets.all(0.0);

  final loadingData = true.obs;
  final delayingMap = true.obs;
  final showOverlayLoadingMap = true.obs;

  bool hasDirectionCoords = false;

  // Data
  late Promocion promocion;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    if (!(Get.arguments is VPSIDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as VPSIDetalleArguments;
    promocion = arguments.promocion;
    if (promocion.latitud != null &&
        promocion.longitud != null &&
        promocion.latitud != 0.0 &&
        promocion.longitud != 0.0) {
      hasDirectionCoords = true;
      initialPosition = CameraPosition(
        target: LatLng(promocion.latitud!, promocion.longitud!),
        zoom: 17.0,
      );
    }

    _init();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }

    hideOverlayLoadingMap();
  }

  Future<void> _init() async {
    loadingData.value = false;
    await Helpers.sleep(600);
    if (_self.isClosed) return;
    delayingMap.value = false;
  }

  Future<void> hideOverlayLoadingMap() async {
    await Helpers.sleep(600);
    if (_self.isClosed) return;
    showOverlayLoadingMap.value = false;
  }
}

class VPSIDetalleArguments {
  final Promocion promocion;

  VPSIDetalleArguments({required this.promocion});
}
