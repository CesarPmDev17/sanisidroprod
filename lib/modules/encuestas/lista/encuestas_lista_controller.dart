import 'dart:io';

import 'package:app_san_isidro/data/models/encuesta.dart';
import 'package:app_san_isidro/data/providers/encuestas_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class EncuestasListaController extends GetxController {
  late EncuestasListaController _self;
  final _authX = Get.find<AuthController>();
  final _encuestaProvider = EncuestaProvider();

  final loadingList = true.obs;
  List<Encuesta> listaEncuestas = [];

  late Directory directoryApp;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    _getEncuestas();
  }

  Future<void> _getEncuestas() async {
    String? errorMsg;
    try {
      loadingList.value = true;

      directoryApp = await getApplicationDocumentsDirectory();

      final resp = await _encuestaProvider.listarEncuesta(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00' || resp.codigoRespuesta == '88') {
        listaEncuestas = resp.listadoEncuestas;
      } else {
        throw BusinessException('Error obteniendo la información');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(1500);
        _getEncuestas();
      } else {
        Get.back();
      }
    } else {
      loadingList.value = false;
    }
  }
}
