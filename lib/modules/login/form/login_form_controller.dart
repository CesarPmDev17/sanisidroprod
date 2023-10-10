import 'package:app_san_isidro/data/models/tipo_doc_identidad.dart';
import 'package:app_san_isidro/data/models/user_create_params.dart';
import 'package:app_san_isidro/data/providers/registro_auth_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginFormController extends GetxController {
  final _keyX = Get.find<KeyboardController>();
  final _registroAuthProvider = RegistroAuthProvider();
  final _authX = Get.find<AuthController>();

  final loadingFormData = false.obs;
  final loadingSubmit = false.obs;

  List<TipoDocIdentidad> tiposDocIdentidad = [];

  TipoDocIdentidad? tipoDocSelected;
  final tipoDocCtlr = TextEditingController();
  final docIdentidadCtlr = TextEditingController();

  int maxLengthDocIdentidad = 1;
  bool isNumericDocIdentidad = true;

  String nombres = '';
  String apePaterno = '';
  String apeMaterno = '';
  String email = '';

  // Extra info

  String ipAddress = '';

  UserCreateParams? userCreateParams;

  final agreeTerms = false.obs;

  final isUserTypeVisisble = true.obs;

  void loginAsUser() {
    isUserTypeVisisble.value = false;
    _fetchDropdowns();
  }

  Future<void> loginAsGuest() async {
    await _authX.setAccessAsGuestUser(true);
    Get.offAllNamed(AppRoutes.HOME);
  }

  Future<void> _fetchDropdowns() async {
    String? errorMsg;
    try {
      loadingFormData.value = true;
      final respListTipoDoc =
          await _registroAuthProvider.listarTiposDocIdentidad();
      tiposDocIdentidad = respListTipoDoc.listadoTipoDocIdentidad;
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado.';
      Helpers.logger.e(e.toString());
    }

    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(2500);
        _fetchDropdowns();
      } else {
        // Aquí no cierro la aplicación en iOS, porque la aplicación puede ser suspendida por apple
        // https://flutteragency.com/how-to-programmatically-exist-the-app-in-flutter/
        // Leer más sobre esto
        loadingFormData.value = false;
      }
    } else {
      loadingFormData.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onContinuarTap() async {
    if (loadingSubmit.value) return;

    try {
      loadingSubmit.value = true;

      await _keyX.closeKeyboardIfOpen();

      if (tipoDocSelected == null) {
        AppSnackbar().warning(
            message:
                'Es necesario seleccionar el tipo de documento de identidad.');
        return;
      }

      if (docIdentidadCtlr.text.trim().isNotEmpty &&
          nombres.isNotEmpty &&
          apePaterno.isNotEmpty &&
          // apeMaterno.isNotEmpty && // Comentado por la exitencia de usuarios específicos
          email.isNotEmpty) {
        if (email.isEmail) {
          if (agreeTerms.value) {
            Get.focusScope?.unfocus();

            userCreateParams = UserCreateParams(
              codUsuario: 0,
              tipoDocIdentidad: tipoDocSelected!.tipoDocIdentidad,
              numDocIdentidad: docIdentidadCtlr.text.trim(),
              telefono: "", // Será completado en la siguiente pantalla
              nombres: nombres,
              apePaterno: apePaterno,
              apeMaterno: apeMaterno,
              correoElectronico: email,
              versionSdk: await DeviceInfoApi.getVersionSDK(),
              modelo: await DeviceInfoApi.getModelo(),
              dispositivo: await DeviceInfoApi.getDispositivo(),
              host: await DeviceInfoApi.getIPAddress(),
              display: await DeviceInfoApi.getScreenResolution(),
              codValidacion: "00",
            );

            Get.toNamed(AppRoutes.LOGIN_PHONE);
          } else {
            AppSnackbar().warning(
                message:
                    'Debe aceptar los términos y condiciones para continuar');
          }
        } else {
          AppSnackbar().warning(message: 'El correo electrónico es inválido');
        }
      } else {
        AppSnackbar()
            .warning(message: 'Es necesario completar todos los datos.');
      }
    } catch (e) {
      Helpers.logger
          .e('Opps! Parece que hubo un error creando el objeto usuario.');
    } finally {
      loadingSubmit.value = false;
    }
  }

  void onSelectTipoDocIdentidad(TipoDocIdentidad tipo) {
    tipoDocSelected = tipo;
    tipoDocCtlr.text = Helpers.capitalizeFirstLetter(tipo.descripcion);

    // Limpia el campo Doc. Identidad
    docIdentidadCtlr.text = '';
    maxLengthDocIdentidad = int.parse(tipo.longitud);
    isNumericDocIdentidad = tipo.esNumerico;
    // Es necesario el update para cambiar el tipo de Keyboard
    update(['gbInputDocIdentidad']);
  }

  Future<void> onCheckTermsTap() async {
    await _keyX.closeKeyboardIfOpen();

    agreeTerms.value = !agreeTerms.value;
  }

  Future<void> onTermsLabelTap() async {
    await _keyX.closeKeyboardIfOpen();

    final result = await Get.toNamed(AppRoutes.LOGIN_TERMS);
    if (result == true) {
      agreeTerms.value = true;
    } else if (result == false) {
      agreeTerms.value = false;
    }
  }

  Future<bool> handleBack() async {
    if (loadingSubmit.value) {
      return false;
    }

    return true;
  }
}
