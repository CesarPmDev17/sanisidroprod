import 'package:app_san_isidro/data/models/expedientes.dart';
import 'package:app_san_isidro/data/providers/pagos_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class PagosExpedientesController extends GetxController {
  late PagosExpedientesController _self;
  final _authX = Get.find<AuthController>();
  final _pagosProvider = PagosProvider();

  final loadingList = true.obs;
  List<Expediente> listExpedientes = [];

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
    _fetchListado();
  }

  Future<void> _fetchListado() async {
    String? errorMsg;
    try {
      loadingList.value = true;
      await Helpers.sleep(600);
      final resp = await _pagosProvider.consultarExpedientes(
        tipoDocIdentidad: _authX.personaStored!.tipoDocIdentidad,
        numDocIdentidad: _authX.personaStored!.numDocIdentidad,
      );
      if (_self.isClosed) return;
      // Para este endpoint. Cuando codRepuesta es 88 es porque no hay datos.
      if (resp.codigoRespuesta == "00" || resp.codigoRespuesta == "88") {
        listExpedientes = resp.listadoExpedientes;
      } else {
        throw BusinessException('Error obteniendo la información.');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado listando los expedientes.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(2500);
        _fetchListado();
      } else {
        Get.back();
      }
    } else {
      loadingList.value = false;
    }
  }
}
