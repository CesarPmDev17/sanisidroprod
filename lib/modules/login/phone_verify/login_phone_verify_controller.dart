import 'package:app_san_isidro/data/models/user_create_params.dart';
import 'package:app_san_isidro/data/providers/registro_auth_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class LoginPhoneVerifyController extends GetxController {
  late LoginPhoneVerifyController _self;
  final _authX = Get.find<AuthController>();
  final _registroAuthProvider = RegistroAuthProvider();
  final telefono = ''.obs;

  final incorrectCode = false.obs;

  final pin1Ctlr = new TextEditingController();
  final pin2Ctlr = new TextEditingController();
  final pin3Ctlr = new TextEditingController();
  final pin4Ctlr = new TextEditingController();
  final pin5Ctlr = new TextEditingController();
  final pin6Ctlr = new TextEditingController();

  final loadingSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();

    _self = this;

    pin1Ctlr.addListener(_onAnyFocus);
    pin2Ctlr.addListener(_onAnyFocus);
    pin3Ctlr.addListener(_onAnyFocus);
    pin4Ctlr.addListener(_onAnyFocus);
    pin5Ctlr.addListener(_onAnyFocus);
    pin6Ctlr.addListener(_onAnyFocus);

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  @override
  void onClose() {
    pin1Ctlr.removeListener(_onAnyFocus);
    pin2Ctlr.removeListener(_onAnyFocus);
    pin3Ctlr.removeListener(_onAnyFocus);
    pin4Ctlr.removeListener(_onAnyFocus);
    pin5Ctlr.removeListener(_onAnyFocus);
    pin6Ctlr.removeListener(_onAnyFocus);

    super.onClose();
  }

  void _onAnyFocus() {
    if (incorrectCode.value) {
      incorrectCode.value = false;
    }

    if (sanitizeOTP().length == 6) {
      onVerificarTap();
    }
  }

  void _init() async {
    if (_authX.personaStored != null) {
      telefono.value = _authX.personaStored!.telefono;
    } else {
      Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(
              content: 'No se pudieron recuperar los datos del usuario.'));
    }
  }

  bool _cambiando = false;
  Future<void> onCambiarTap() async {
    if (_cambiando) return;
    _cambiando = true;

    // Limpia la persona de Auth y del dispositivo
    await _authX.setAccessAsRegisteredUser(null);
    Get.offAllNamed(AppRoutes.LOGIN_FORM);
  }

  Future<void> onVerificarTap() async {
    if (loadingSubmit.value) return;
    if (_authX.personaStored == null) return;

    String otpCode = sanitizeOTP();
    String savedCode = _authX.personaStored!.codValidacion;

    if (savedCode != otpCode) {
      incorrectCode.value = true;
      return;
    }

    String? errorMsg;
    try {
      loadingSubmit.value = true;
      await Helpers.sleep(1500);
      final resp = await _registroAuthProvider
          .activarUsuario(_authX.personaStored!.codUsuario);

      // Guarda la persona con el flag estadoValidacion en TRUE
      await _authX.setAccessAsRegisteredUser(resp.personaRegistrada.copyWith(
        estadoValidacion: true,
        lastLogin: DateTime.now(),
      ));
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } on BusinessException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg = 'Ocurrió un error inesperado activando el usuario.';
      Helpers.logger.e(e.toString());
    } finally {
      loadingSubmit.value = false;
    }

    if (_self.isClosed) return;

    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));
      if (ers == MiscErrorResult.retry) {
        onVerificarTap();
      }
    } else {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  final resending = false.obs;
  Future<void> onResendSMS() async {
    pin1Ctlr.text = '';
    pin2Ctlr.text = '';
    pin3Ctlr.text = '';
    pin4Ctlr.text = '';
    pin5Ctlr.text = '';
    pin6Ctlr.text = '';

    if (resending.value) return;
    if (_authX.personaStored == null) return;

    try {
      resending.value = true;

      final ps = _authX.personaStored!;
      final userParams = UserCreateParams(
        codUsuario: 0,
        tipoDocIdentidad: ps.tipoDocIdentidad,
        numDocIdentidad: ps.numDocIdentidad,
        telefono: ps.telefono, // Será completado en la siguiente pantalla
        nombres: ps.nombres,
        apePaterno: ps.apePaterno,
        apeMaterno: ps.apeMaterno,
        correoElectronico: ps.correoElectronico,
        versionSdk: await DeviceInfoApi.getVersionSDK(),
        modelo: await DeviceInfoApi.getModelo(),
        dispositivo: await DeviceInfoApi.getDispositivo(),
        host: await DeviceInfoApi.getIPAddress(),
        display: await DeviceInfoApi.getScreenResolution(),
        codValidacion: "00",
      );
      final resp = await _registroAuthProvider.registrarPersona(userParams);
      final now = new DateTime.now();
      final expCodeDate = now.add(new Duration(hours: 2));
      // Adjuntamos una fecha de expiración a la persona registrada
      final personaWithExpDate =
          resp.personaRegistrada.copyWith(expValidacionDate: expCodeDate);
      // Guarda los datos actualizados
      await _authX.setAccessAsRegisteredUser(personaWithExpDate);
      AppSnackbar().success(message: 'SMS enviado!');
    } catch (e) {
      Helpers.logger.e(e.toString());
    } finally {
      resending.value = false;
    }
  }

  String sanitizeOTP() {
    String pin1 = pin1Ctlr.text.trim();
    String pin2 = pin2Ctlr.text.trim();
    String pin3 = pin3Ctlr.text.trim();
    String pin4 = pin4Ctlr.text.trim();
    String pin5 = pin5Ctlr.text.trim();
    String pin6 = pin6Ctlr.text.trim();
    String otpCode = '$pin1$pin2$pin3$pin4$pin5$pin6';
    return otpCode;
  }

  Future<bool> handleBack() async {
    if (loadingSubmit.value || resending.value) return false;

    return true;
  }
}
