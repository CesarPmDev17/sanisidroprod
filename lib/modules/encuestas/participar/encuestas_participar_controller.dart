import 'dart:io';

import 'package:app_san_isidro/data/models/encuesta.dart';
import 'package:app_san_isidro/data/providers/encuestas_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class EncuestasParticiparController extends GetxController {
  late EncuestasParticiparController _self;
  final _keyX = Get.find<KeyboardController>();
  final _authX = Get.find<AuthController>();
  final _encuestaProvider = EncuestaProvider();

  late Directory directoryApp;
  late Encuesta encuesta;

  final fetchingData = true.obs;
  final sendLoading = false.obs;

  final gbPreguntas = 'gbListaPreguntas';

  List<Opcion> preguntas = [];

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is EncuestasParticiparArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as EncuestasParticiparArguments;
    encuesta = arguments.encuesta;

    _getOpciones();
  }

  Future<void> _getOpciones() async {
    String? errorMsg;
    try {
      fetchingData.value = true;

      directoryApp = await getApplicationDocumentsDirectory();

      await Helpers.sleep(300);

      final resp = await _encuestaProvider.listarOpciones(
        codEncuesta: encuesta.codEncuesta,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta == "00") {
        preguntas = resp.listadoOpciones;
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
        _getOpciones();
      } else {
        Get.back();
      }
    } else {
      fetchingData.value = false;
    }
  }

  void onOptionTap(int codPregunta, int codOpcion) {
    final preguntaFound =
        preguntas.firstWhere((p) => p.codEncuestaPregunta == codPregunta);

    preguntaFound.alternativas.forEach((o) {
      o.seleccionado = false;
    });

    final opcionFound =
        preguntaFound.alternativas.firstWhere((o) => o.codOpcion == codOpcion);
    opcionFound.seleccionado = true;

    update([gbPreguntas]);
  }

  void onButtonSendTap() {
    _sendForm();
  }

  Future<void> _sendForm() async {
    if (sendLoading.value) return;

    List<dynamic> respuestas = [];
    for (int i = 0; i < preguntas.length; i++) {
      bool existsResponse = false;
      int codOpcionSeleccionado = 0;
      preguntas[i].alternativas.forEach((e) {
        if (e.seleccionado == true) {
          existsResponse = true;
          codOpcionSeleccionado = e.codOpcion;
        }
      });

      if (!existsResponse) {
        AppSnackbar().warning(message: 'Debe responder todas las preguntas.');
        return;
      }

      respuestas.add({
        "CodEncuestaWeb": "",
        "CodEncuesta": preguntas[i].codEncuesta,
        "CodEncuestaPregunta": preguntas[i].codEncuestaPregunta,
        "CodOpcion": codOpcionSeleccionado
      });
    }

    // Enviando form
    String? errorMsg;
    try {
      sendLoading.value = true;
      await _keyX.closeKeyboardIfOpen();
      await Helpers.sleep(600);
      final resp = await _encuestaProvider.registrarEncuesta(
        codEncuesta: encuesta.codEncuesta,
        codUsuario: _authX.personaStored!.codUsuario,
        respuestas: respuestas,
      );
      if (_self.isClosed) return;
      if (resp.codigoRespuesta != '00') {
        throw BusinessException('Error enviando el formulario');
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
        sendLoading.value = false;
        _sendForm();
      } else {
        sendLoading.value = false;
      }
    } else {
      sendLoading.value = false;
      Get.offNamed(AppRoutes.ENCUESTAS_SUCCESS);
    }
  }

  Future<bool> handleBack() async {
    if (sendLoading.value) {
      return false;
    }
    return true;
  }
}

class EncuestasParticiparArguments {
  final Encuesta encuesta;

  EncuestasParticiparArguments({required this.encuesta});
}
