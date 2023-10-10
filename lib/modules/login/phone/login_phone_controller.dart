import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/data/providers/registro_auth_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/login/form/login_form_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class LoginPhoneController extends GetxController {
  late LoginPhoneController _self;
  final _authX = Get.find<AuthController>();
  final _loginFormX = Get.find<LoginFormController>();
  final _registroAuthProvider = RegistroAuthProvider();

  final loadingSubmit = false.obs;

  String telefono = '';

  @override
  void onInit() {
    super.onInit();
    _self = this;
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onContinuarTap() async {
    if (loadingSubmit.value) return;

    if (telefono.length < 9) {
      AppSnackbar().warning(message: 'No es un número de celular válido');
      return;
    }

    String? errorMsg;
    try {
      loadingSubmit.value = true;

      // Agregando el telefono a los parámetros
      _loginFormX.userCreateParams = _loginFormX.userCreateParams!.copyWith(
        telefono: telefono,
      );
      await Helpers.sleep(1500);
      final resp = await _registroAuthProvider
          .registrarPersona(_loginFormX.userCreateParams!);

      final now = new DateTime.now();
      final expCodeDate = now.add(new Duration(hours: 2));
      // Adjuntamos una fecha de expiración a la persona registrada
      final personaWithExpDate =
          resp.personaRegistrada.copyWith(expValidacionDate: expCodeDate);

      if (!Config().isProduction) {
        print(resp.personaRegistrada.codValidacion);
      }

      // Guarda la persona en Auth y en la memoria del dispositivo.
      await _authX.setAccessAsRegisteredUser(personaWithExpDate);
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado registrando la persona.';
      Helpers.logger.e(e.toString());
    } finally {
      loadingSubmit.value = false;
    }

    Get.focusScope?.unfocus();
    if (_self.isClosed) return;

    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        onContinuarTap();
      }
    } else {
      Get.toNamed(AppRoutes.LOGIN_PHONE_VERIFY);
    }
  }

  Future<bool> handleBack() async {
    if (loadingSubmit.value) {
      return false;
    }

    return true;
  }
}
