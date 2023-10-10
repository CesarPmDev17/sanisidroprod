import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/pagos/deudas/pagos_deudas_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:get/get.dart';

class PagosInicioController extends GetxController {
  final _authX = Get.find<AuthController>();

  bool isContribuyente = false;

  @override
  void onInit() {
    super.onInit();

    isContribuyente = _authX.personaStored!.codContribuyente != 'null';
  }

  Future<void> onDeudasPendientesTap() async {
    // Asegurandonos de limpiar el Bloc de deudas
    await Get.delete<PagosDeudasController>();
    Get.toNamed(AppRoutes.PAGOS_DEUDAS);
  }

  void onEstadoCuentaTap() {
    Get.toNamed(AppRoutes.PAGOS_ESTADO_CUENTA);
  }

  void onPagosRealizadosTap() {
    Get.toNamed(AppRoutes.PAGOS_LISTA);
  }

  void onConsultaExpedientesTap() {
    Get.toNamed(AppRoutes.PAGOS_EXPEDIENTES);
  }
}
