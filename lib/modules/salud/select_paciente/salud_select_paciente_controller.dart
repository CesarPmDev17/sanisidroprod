import 'package:app_san_isidro/modules/salud/lista/salud_lista_controller.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:get/get.dart';

class SaludSelectPacienteController extends GetxController {
  final loading = false.obs;

  final personaData = (Get.find<SaludListaController>()).personaVerified!;

  final _nuevaResevaX = Get.find<SaludNuevaReservaController>();

  Future<void> onContinueTap() async {
    if (loading.value) return;

    // Seleccion del CodPersona Correcto
    _nuevaResevaX.setCodPaciente(personaData.codpersona);
    Get.toNamed(AppRoutes.SALUD_ESPECIALIDAD);
  }

  String get getFullName =>
      personaData.txtnombre +
      ' ' +
      personaData.txtapepat +
      ' ' +
      personaData.txtapemat;
}
