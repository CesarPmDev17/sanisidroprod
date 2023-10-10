import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/data/providers/modulos_app_provider.dart';
import 'package:app_san_isidro/data/providers/vpsi_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum VPSIMemberType { platinum, black }

class VPSIMiTarjetaController extends GetxController {
  late VPSIMiTarjetaController _self;
  final _authX = Get.find<AuthController>();
  final _vpsiProvider = VpsiProvider();
  final _modulosAppProvider = ModulosAppProvider();

  VPSIMemberType memberType = VPSIMemberType.black;
  String nombre = '';
  String codContribuyente = '';

  PerfilUsuario? perfilUsuario;

  final fetchLoading = true.obs;

  late Image imgBlackCardCache;
  late Image imgPlatinumCardCache;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    imgBlackCardCache = Image.asset("assets/img/tarjeta_vpsi_01.png");
    imgPlatinumCardCache = Image.asset("assets/img/tarjeta_vpsi_02.png");

    _checkServicioDisponible();
  }

  Future<void> _checkServicioDisponible() async {
    bool servicioDisponible = false;
    try {
      final resp = await _modulosAppProvider.listarDisponibilidad();
      if (resp.codigoRespuesta == '00') {
        for (var i = 0; i < resp.listadoModuloApp.length; i++) {
          if (resp.listadoModuloApp[i].txtmodulo == 'VPSIAPP' &&
              resp.listadoModuloApp[i].flgmodulo == 'TRUE') {
            servicioDisponible = true;
          }
        }
      }
    } catch (e) {
      Helpers.logger.e('Error recuperando la lista de disponibilidad');
    }

    if (servicioDisponible) {
      _fetchData();
    } else {
      await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(
              content:
                  'Módulo en mantenimiento. Por favor, inténtalo más tarde.'));
      Get.back();
    }
  }

  Future<void> _fetchData() async {
    String? errorMsg;
    try {
      fetchLoading.value = true;
      await Helpers.sleep(300);
      final resp = await _vpsiProvider.consultarPerfilVPSI(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        final tipoVpsi = resp.perfilUsuario.tipoTarjetaVpsi;
        final descTipoVpsi = resp.perfilUsuario.descripcionTipoTarjetaVpsi;

        if (tipoVpsi != null &&
            tipoVpsi != 'null' &&
            descTipoVpsi != null &&
            descTipoVpsi != 'null') {
          perfilUsuario = resp.perfilUsuario;

          memberType = perfilUsuario!.tipoTarjetaVpsi == '01'
              ? VPSIMemberType.black
              : VPSIMemberType.platinum;
          nombre =
              '${perfilUsuario!.nombres} ${perfilUsuario!.apePaterno} ${perfilUsuario!.apeMaterno}';
          codContribuyente = _authX.personaStored!.codContribuyente;

          // Pre cargando las imagenes
          if (memberType == VPSIMemberType.black) {
            await precacheImage(imgBlackCardCache.image, Get.context!);
          } else {
            await precacheImage(imgPlatinumCardCache.image, Get.context!);
          }
        } else {
          throw Exception('Error inesperado al generar la tarjeta');
        }
      } else {
        throw Exception('Error inesperado');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado descargando información de tarjeta VPSI.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _fetchData();
      } else {
        fetchLoading.value = false;
        Get.back();
      }
    } else {
      fetchLoading.value = false;
    }
  }
}
