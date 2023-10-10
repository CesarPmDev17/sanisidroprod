import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/data/providers/vecino_comunica_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class VecinoComunicaCasosController extends GetxController {
  late VecinoComunicaCasosController _self;
  final _authX = Get.find<AuthController>();
  final _vecinoComunicaProvider = VecinoComunicaProvider();

  final loadingList = true.obs;
  List<CasoSav> listaCasos = [];

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    _getMisCasos();
  }

  Future<void> _getMisCasos() async {
    String? errorMsg;
    try {
      loadingList.value = true;
      final resp = await _vecinoComunicaProvider.listarCasosSAV(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        listaCasos = resp.listaCasosSav;
      } else {
        throw Exception('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado listando los casos - Vecino Comunica.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _getMisCasos();
      } else {
        Get.back();
      }
    } else {
      loadingList.value = false;
    }
  }
}
