import 'dart:io';

import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/data/providers/vecino_comunica_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class VecinoComunicaDetalleController extends GetxController {
  // Instances
  late VecinoComunicaDetalleController _self;
  final _authX = Get.find<AuthController>();
  final _vecinoComunicaProvider = VecinoComunicaProvider();

  final fetchingData = true.obs;

  // Data
  String numeroCaso = '';
  DetalleCasoSAVResponse? detalle;

  Directory? directoryApp;
  String appPath = '';

  @override
  void onInit() {
    super.onInit();
    _self = this;
    _init();
  }

  File? img1;
  File? img2;
  File? img3;

  Future<void> _init() async {
    if (!(Get.arguments is VecinoComunicaDetalleArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as VecinoComunicaDetalleArguments;
    numeroCaso = arguments.numeroCaso;

    directoryApp = await getApplicationDocumentsDirectory();
    appPath = directoryApp!.path;

    _getData();
  }

  void writeFile() async {}

  Future<void> _getData() async {
    String? errorMsg;
    try {
      fetchingData.value = true;
      await Helpers.sleep(300);

      writeFile();

      final resp = await _vecinoComunicaProvider.detalleCasoSAV(
        codUsuario: _authX.personaStored!.codUsuario,
        codContribuyente: _authX.personaStored!.codContribuyente,
        numeroCaso: numeroCaso,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == '00') {
        detalle = resp;

        // Construyendo las imágenes
        if (resp.archivoComunicacion1 != null &&
            Helpers.checkIfDataBase64IsImage(resp.archivoComunicacion1!)) {
          img1 = File('$appPath/vecino_comunica_img_1.pdf');
          img1!
            ..writeAsBytesSync(
                Helpers.getDecodedBytes(resp.archivoComunicacion1!));
        }
        if (resp.archivoComunicacion2 != null &&
            Helpers.checkIfDataBase64IsImage(resp.archivoComunicacion2!)) {
          img2 = File('$appPath/vecino_comunica_img_2.pdf');
          img2!
            ..writeAsBytesSync(
                Helpers.getDecodedBytes(resp.archivoComunicacion2!));
        }
        if (resp.archivoComunicacion3 != null &&
            Helpers.checkIfDataBase64IsImage(resp.archivoComunicacion3!)) {
          img3 = File('$appPath/vecino_comunica_img_3.pdf');
          img3!
            ..writeAsBytesSync(
                Helpers.getDecodedBytes(resp.archivoComunicacion3!));
        }
      } else {
        throw BusinessException(
            'Error obteniendo la información - Detalle Vecino Comunica');
      }
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado en el detalle del caso - Vecino Comunica';
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
      fetchingData.value = false;
    }
  }
}

class VecinoComunicaDetalleArguments {
  final String numeroCaso;

  VecinoComunicaDetalleArguments({required this.numeroCaso});
}
