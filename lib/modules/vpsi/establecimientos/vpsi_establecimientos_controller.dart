import 'package:app_san_isidro/data/models/vpsi.dart';
import 'package:app_san_isidro/data/providers/modulos_app_provider.dart';
import 'package:app_san_isidro/data/providers/vpsi_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/modules/vpsi/detalle/vpsi_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class VPSIEstablecimientosController extends GetxController {
  late VPSIEstablecimientosController _self;
  final _authX = Get.find<AuthController>();
  final _keyX = Get.find<KeyboardController>();
  final _vpsiProvider = VpsiProvider();
  final _modulosAppProvider = ModulosAppProvider();

  final fetchingLoading = true.obs;
  List<Promocion> listPromociones = [];

  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    debounce<String>(searchText, (txt) {
      filterPromocion(txt);
    }, time: Duration(milliseconds: 600));

    _init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _init() async {
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
    String? tipoTarjetaVPSI;
    try {
      fetchingLoading.value = true;
      await Helpers.sleep(300);
      final resp = await _vpsiProvider.consultarPerfilVPSI(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
      );

      if (resp.codigoRespuesta == '00') {
        tipoTarjetaVPSI = resp.perfilUsuario.tipoTarjetaVpsi;
      } else {
        throw Exception('Error inesperado');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado obteniendo el tipo tarjeta VPSI.';
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
        Get.back();
      }
    } else {
      fetchingLoading.value = false;

      _fetchEstablecimientos(tipoTarjetaVPSI!);
    }
  }

  Future<void> _fetchEstablecimientos(String tipoTarjetaVPSI) async {
    String? errorMsg;
    try {
      fetchingLoading.value = true;
      final resp = await _vpsiProvider.listarPromocionesVPSI(tipoTarjetaVPSI);
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        listPromociones = [...resp.listaPromociones];
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando los establecimientos.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _fetchEstablecimientos(tipoTarjetaVPSI);
      } else {
        fetchingLoading.value = false;
        Get.back();
      }
    } else {
      fetchingLoading.value = false;
    }
  }

  void filterPromocion(String term) {
    update(['gbList']);
  }

  Future<void> goToDetailsPage(Promocion promo) async {
    await _keyX.closeKeyboardIfOpen();
    Get.toNamed(AppRoutes.VPSI_DETALLE,
        arguments: VPSIDetalleArguments(promocion: promo));
  }
}
