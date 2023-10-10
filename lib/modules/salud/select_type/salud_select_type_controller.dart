import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class SaludSelectTypeController extends GetxController {
  final tipo = Rx<TipoNuevaReservaCita?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTipoButtonTap(TipoNuevaReservaCita t) {
    this.tipo.value = t;
  }

  Future<void> onContinueTap() async {
    if (tipo.value == null) {
      AppSnackbar().warning(message: 'Primero selecciona el tipo de cita');
      return;
    }

    // Inyectamos el controlador para las nuevas reservas
    await Get.delete<SaludNuevaReservaController>();
    final _localNuevaReservaX = Get.put(SaludNuevaReservaController());
    _localNuevaReservaX.setTipoReserva(tipo.value!);

    await Get.toNamed(AppRoutes.SALUD_SELECT_PACIENTE);
  }
}
