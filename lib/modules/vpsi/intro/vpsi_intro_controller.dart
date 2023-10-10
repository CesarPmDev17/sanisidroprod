import 'package:app_san_isidro/data/providers/vpsi_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class VPSIIntroController extends GetxController {
  late VPSIIntroController _self;

  final _authX = Get.find<AuthController>();

  final _vpsiProvider = VpsiProvider();

  final gbScaffold = 'gbScaffold';
  bool checking = true;
  bool isVPSI = false;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _checkVpsiRequirements();
  }

  /// Está función verifica los requerimientos para ser VPSI
  /// 1- Ser contribuyente
  /// 2- Estar al día en sus pagos de tributos.
  Future<void> _checkVpsiRequirements() async {
    await Helpers.sleep(800);
    await tryCatch(
      self: _self,
      code: () async {
        if (_authX.esContribuyente) {
          final resp = await _vpsiProvider.consultarPerfilVPSI(
            codUsuario: _authX.personaStored!.codUsuario,
            codContribuyente: _authX.personaStored!.codContribuyente,
          );

          if (resp.codigoRespuesta == '00') {
            final tipoVpsi = resp.perfilUsuario.tipoTarjetaVpsi;
            final descTipoVpsi = resp.perfilUsuario.descripcionTipoTarjetaVpsi;

            if (tipoVpsi != null &&
                tipoVpsi != 'null' &&
                descTipoVpsi != null &&
                descTipoVpsi != 'null') {
              isVPSI = true;
            }
          }
        }
      },
      onCancelRetry: () async => Get.back(),
    );

    checking = false;
    update([gbScaffold]);
  }

  void goToMiTarjetaPage() {
    Get.toNamed(AppRoutes.VPSI_MI_TARJETA);
  }

  void goToEstablecimientoPage() {
    Get.toNamed(AppRoutes.VPSI_ESTABLECIMIENTOS);
  }

  void goToConocerPage() {
    Get.toNamed(AppRoutes.VPSI_CONOCER);
  }

  Future<bool> handleBack() async {
    if (checking) return false;
    return true;
  }
}
