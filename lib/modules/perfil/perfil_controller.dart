import 'package:app_san_isidro/data/models/persona_registrada.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  final authX = Get.find<AuthController>();
  PersonaRegistrada? data;

  String nombreCompleto = '';

  String appVersion = '';
  @override
  void onInit() {
    super.onInit();

    data = authX.personaStored;
    appVersion = authX.packageInfo.version;

    final n = data?.nombres ?? '';
    final ap = data?.apePaterno ?? '';
    final am = data?.apeMaterno ?? '';
    nombreCompleto = '$n $ap $am';
  }

  void onLogoutButtonTap() {
    authX.logout();
  }
}
