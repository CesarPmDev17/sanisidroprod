import 'package:app_san_isidro/data/models/persona_registrada.dart';
import 'package:app_san_isidro/modules/prefs/prefs_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthController extends GetxController {
  final _prefsX = Get.find<PrefsController>();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  PackageInfo get packageInfo => this._packageInfo;

  /// Determina si el usuario selecciono el tipo de usuario.
  /// Ya sea un usuario Guest o Authed.
  bool _isLogged = false;
  bool get isLogged => this._isLogged;

  /// Verifica si el usuario logueado es Guest
  bool _isGuest = true;
  bool get isGuest => this._isGuest;

  PersonaRegistrada? _personaStored;
  PersonaRegistrada? get personaStored => this._personaStored;

  bool get esContribuyente => this.personaStored != null
      ? (this.personaStored!.codContribuyente != 'null')
      : false;

  /// Almacena isLogged=true y Persona en memoria y shared preferences.
  ///
  /// Si se envía null, hace un reset
  Future<void> setAccessAsRegisteredUser(PersonaRegistrada? persona) async {
    this._isLogged = persona != null;
    await _prefsX.setIsLoggedStatus(persona != null);
    this._personaStored = persona;
    await _prefsX.setPersonaSavedInPhone(persona);
    this._isGuest = persona == null;
  }

  /// Almacena isLogged=true memoria y shared preferences. Persona siempre será null al tratarse de un GuestUser
  ///
  /// Si se envía false, hace un reset
  Future<void> setAccessAsGuestUser(bool value) async {
    this._isLogged = value;
    await _prefsX.setIsLoggedStatus(value);
    // Para un GuestUser, personaStored siempre debe ser null
    this._personaStored = null;
    await _prefsX.setPersonaSavedInPhone(null);
    this._isGuest = true;
  }

  @override
  void onInit() {
    super.onInit();

    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
  }

  Future<void> handleUserStatus() async {
    this._isLogged = _prefsX.isLoggedStatus;
    if (!this._isLogged) {
      await logout();
      return;
    }

    try {
      this._personaStored = _prefsX.personaSavedInPhone;
      if (this._personaStored != null) {
        this._isGuest = false;
        // Persona registrada
        if (this._personaStored!.estadoValidacion) {
          Get.offAllNamed(AppRoutes.HOME);
        } else {
          Get.offAllNamed(AppRoutes.LOGIN_PHONE_VERIFY);
        }
      } else {
        this._isGuest = true;
        // Guest User
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      await logout();
      return;
    }
  }

  Future<void> logout() async {
    Helpers.logger.i('Clean and go to Login');
    await setAccessAsRegisteredUser(null);
    await _prefsX.deleteAll();

    // Es necesario establecer estos dos valores, de lo contrario
    // Lo tomará como una instalación nueva
    await _prefsX.setFirstRun(false);
    await _prefsX.setIntroViewed(true);

    Get.offAllNamed(AppRoutes.LOGIN_FORM);
  }
}
