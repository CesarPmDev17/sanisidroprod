import 'package:app_san_isidro/data/models/alerta.dart';
import 'package:app_san_isidro/data/providers/alerta_seguridad_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class AlertaHistorialController extends GetxController {
  late AlertaHistorialController _self;
  final _authX = Get.find<AuthController>();
  final _alertaSeguridadProvider = AlertaSeguridadProvider();

  final loadingList = true.obs;
  List<Alerta> listAlertas = [];

  @override
  void onInit() {
    super.onInit();
    _self = this;
    _init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _init() async {
    _getMisAlertas();
  }

  Future<void> _getMisAlertas() async {
    String? errorMsg;
    try {
      loadingList.value = true;
      await Helpers.sleep(600);
      final resp = await _alertaSeguridadProvider.listarMisAlertas(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        listAlertas = resp.casosRegistrados;
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando las alertas.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _getMisAlertas();
      } else {
        Get.back();
      }
    } else {
      loadingList.value = false;
    }
  }
}
