import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

class MiscErrorController extends GetxController {
  String title = 'Opps!';
  String content = 'Parece que hubo un error.\nInténtalo de nuevo.';
  bool shouldResetApp = false;

  String appVersion = '';
  String fechaString = '';

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is MiscErrorArguments) {
      final arguments = Get.arguments as MiscErrorArguments;

      title = arguments.title ?? title;
      content = arguments.content ?? content;

      shouldResetApp = arguments.shouldResetApp ?? shouldResetApp;
      if (shouldResetApp) {
        content = arguments.content ??
            'Ocurrió un problema inesperado. Cierra y vuelve a iniciar la aplicación';
      }
    }

    try {
      final _authXTemp = Get.find<AuthController>();
      appVersion = _authXTemp.packageInfo.version;

      final now = DateTime.now();
      fechaString =
          formatDate(now, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]);
    } catch (e) {
      Helpers.logger.e('MiscX: no se pudo obtener la versión de app');
      Helpers.logger.e(e);
    }
  }

  void onRetryButtonTap() {
    Get.back(result: MiscErrorResult.retry);
  }

  void onCancelButtonTap() {
    Get.back(result: MiscErrorResult.cancel);
  }
}

enum MiscErrorResult { retry, cancel }

class MiscErrorArguments {
  /// Cuando es true, añade un tag random a MiscErrorController para evitar que use otro controlador que quede en memoria por el delay que hay al removerlo
  final bool randomTag;
  final String? title;
  final String? content;

  /// Por defecto es falso. Cuando es true, muestra un mensaje indicando reiniciar la aplicación. En android agrega un botón para cerrar la app.
  final bool? shouldResetApp;

  const MiscErrorArguments(
      {this.randomTag = false, this.title, this.content, this.shouldResetApp});
}
