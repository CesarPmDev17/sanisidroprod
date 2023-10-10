import 'dart:async';
import 'dart:convert';

import 'package:app_san_isidro/data/models/alerta.dart';
import 'package:app_san_isidro/data/providers/alerta_seguridad_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/fresh_map_theme.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertaDetalleController extends GetxController {
  // Instances
  late AlertaDetalleController _self;
  final _authX = Get.find<AuthController>();
  final _alertaSeguridadProvider = AlertaSeguridadProvider();

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

  // Data
  String numeroCaso = '';
  AlertaDetalleResponse? alertaData;

  @override
  void onInit() {
    super.onInit();
    _self = this;
    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is AlertaDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as AlertaDetalleArguments;
    numeroCaso = arguments.numeroCaso;
    _getData();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(freshMapTheme));
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }

    hideOverlayLoadingMap();
  }

  Future<void> _getData() async {
    String? errorMsg;
    try {
      loadingData.value = true;
      await Helpers.sleep(200);
      final resp = await _alertaSeguridadProvider.detalleAlerta(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
        numeroCaso: numeroCaso,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        alertaData = resp;
        initialPosition = CameraPosition(
          target: LatLng(alertaData!.latitud, alertaData!.longitud),
          zoom: 17.0,
        );
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado obteniendo el detalle de la alerta.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _getData();
      } else {
        Get.back();
      }
    } else {
      loadingData.value = false;
      await Helpers.sleep(600);
      if (_self.isClosed) return;
      delayingMap.value = false;
    }
  }

  Future<void> hideOverlayLoadingMap() async {
    await Helpers.sleep(600);
    if (_self.isClosed) return;
    showOverlayLoadingMap.value = false;
  }
}

class AlertaDetalleArguments {
  final String numeroCaso;

  AlertaDetalleArguments({required this.numeroCaso});
}
