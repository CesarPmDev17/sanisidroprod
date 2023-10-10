import 'dart:async';

import 'package:app_san_isidro/data/providers/alerta_seguridad_provider.dart';
import 'package:app_san_isidro/modules/alerta/confirmacion/alerta_confirmacion_controller.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/misc/permisos_info/misc_permisos_info_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as lct;
import 'package:permission_handler/permission_handler.dart';

class HomeAlertingController extends GetxController
    with SingleGetTickerProviderMixin {
  late HomeAlertingController _self;
  late AnimationController animOutlinedCtlr;
  late AnimationController animOutlinedCtlr2;

  final lct.Location location = lct.Location.instance;

  final _authX = Get.find<AuthController>();
  final _alertaSeguridadProvider = AlertaSeguridadProvider();

  final mainMessage = 'Obteniendo posición...'.obs;

  // Timers
  Timer? _timerSosTxt;
  final showAlertLottie = false.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  @override
  void onClose() {
    _timerSosTxt?.cancel();
    animOutlinedCtlr.dispose();
    animOutlinedCtlr2.dispose();

    super.onClose();
  }

  Future<void> _init() async {
    animOutlinedCtlr = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      lowerBound: 400,
      upperBound: 600,
    );

    animOutlinedCtlr2 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      lowerBound: 500,
      upperBound: 700,
    );

    animOutlinedCtlr.repeat();
    // await Helpers.sleep(1000);
    animOutlinedCtlr2.repeat();

    _startSosChangeAnimation();

    // Incrustando lógica de permisos
    final permissionEnabled = await _checkAppPermissions();

    if (!permissionEnabled) {
      await Helpers.sleep(600);
      final goSettings = await Get.toNamed(
        AppRoutes.MISC_PERMISOS_INFO,
        arguments: MiscPermisosInfoArguments(
          message:
              'Es necesario que habilites tu localización para georeferenciar las alertas de emergencia.',
        ),
      );
      await Helpers.sleep(300);
      if (goSettings == true) {
        openAppSettings();
        // Retrocedemos para no tener que manipular el onResume
        Get.back();
      } else {
        // Retrocedemos para no tener que manipular el onResume
        Get.back();
      }
    } else {
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (isLocationEnabled) {
        _configPosition();
      } else {
        bool gpsEnabled = await location.requestService();
        if (gpsEnabled) {
          _configPosition();
        }
      }
    }
  }

  Future<bool> _checkAppPermissions() async {
    bool permissionLocation = await Permission.location.isGranted;

    PermissionStatus? plocationStatus;
    if (!permissionLocation) {
      plocationStatus = await Permission.location.request();
    }

    if (permissionLocation) {
      return true;
    } else {
      final resp = _handlePermissionLocationResponse(plocationStatus!);
      return resp;
    }
  }

  Future<bool> _handlePermissionLocationResponse(
      PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.limited:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
      default:
        return false;
    }
  }

  // Mi ubicación
  late Position _myPosition;
  Position get myPosition => this._myPosition;

  void _configPosition() async {
    if (_self.isClosed) return;

    try {
      final lastPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _myPosition = lastPosition;

      _enviarAlerta();
    } catch (e) {
      if (_self.isClosed) return;
      // En este caso elimina la ruta actual y la reemplaza con la del error
      await Get.offNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(
              content:
                  'Debes habilitar el servicio de ubicación para enviar alertas'));
    }
  }

  Future<void> _startSosChangeAnimation() async {
    await Helpers.sleep(1000);
    _toggleSOSLottie();
    await Helpers.sleep(2000);
    _toggleSOSLottie();

    _timerSosTxt?.cancel();
    _timerSosTxt = Timer.periodic(Duration(milliseconds: 2000), (_) {
      _toggleSOSLottie();
    });
  }

  Future<void> _enviarAlerta() async {
    await Helpers.sleep(3000);
    mainMessage.value = 'Enviando alerta...';

    String? errorMsg;
    String numeroCaso = '';
    try {
      if (_self.isClosed) return;

      final disponible = await Helpers.checkServicioDisponible('ALERTASOSAPP');
      if (!disponible) {
        Get.back();
        return;
      }

      final resp = await _alertaSeguridadProvider.registrarAlerta(
        codUsuario: _authX.personaStored!.codUsuario,
        telefono: _authX.personaStored!.telefono,
        //  Asegurar que los demás módulos envien un máximo de 6 digitos para evitar error con el backend.
        latitud: '${myPosition.latitude.toStringAsFixed(6)}',
        longitud: '${myPosition.longitude.toStringAsFixed(6)}',
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        numeroCaso = resp.alertaRegistrada.numeroCaso;
      } else {
        throw BusinessException('Hubo un error registrando la alerta');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado reportando la alerta.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _enviarAlerta();
      } else {
        Get.back();
      }
    } else {
      Get.offNamed(
        AppRoutes.ALERTA_CONFIRMACION,
        arguments: AlertaConfirmacionArguments(numeroCaso: numeroCaso),
      );
    }
  }

  void _toggleSOSLottie() {
    showAlertLottie.value = !showAlertLottie.value;
  }
}
