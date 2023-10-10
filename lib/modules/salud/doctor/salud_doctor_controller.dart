import 'package:app_san_isidro/data/models/doctor.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class SaludDoctorController extends GetxController {
  final _keyX = Get.find<KeyboardController>();
  late SaludDoctorController _self;

  final _nuevaResevaX = Get.find<SaludNuevaReservaController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  // GetBuilder ID's
  final gbList = 'gbList';

  final fetchingLoading = true.obs;
  List<Doctor> list = [];

  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    debounce<String>(searchText, (txt) {
      filterPromocion(txt);
    }, time: Duration(milliseconds: 600));

    _init();
  }

  Future<void> _init() async {
    await tryCatch(
      self: _self,
      code: () async {
        final codEspecialidad =
            _nuevaResevaX.nuevaReserva.especialidad?.codespecialidad;

        if (codEspecialidad == null)
          throw BusinessException('No se ha seleccionado la especialidad');

        final resp =
            await _citasMedicasProvider.listarDoctores(codEspecialidad);
        list = resp.datos;
      },
    );

    fetchingLoading.value = false;
  }

  void filterPromocion(String term) {
    update([gbList]);
  }

  Future<void> onItemTap(Doctor item) async {
    _nuevaResevaX.setDoctor(item);

    await _keyX.closeKeyboardIfOpen();
    Get.toNamed(AppRoutes.SALUD_FECHA);
  }
}
