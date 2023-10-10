import 'package:app_san_isidro/data/models/especialidad.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/keyboard/keyboard_controller.dart';
import 'package:app_san_isidro/modules/salud/nueva_reserva/salud_nueva_reserva_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class SaludEspecialidadController extends GetxController {
  final _keyX = Get.find<KeyboardController>();
  late SaludEspecialidadController _self;

  final _nuevaResevaX = Get.find<SaludNuevaReservaController>();

  final _citasMedicasProvider = CitasMedicasProvider();

  // GetBuilder ID's
  final gbList = 'gbList';

  final fetchingLoading = true.obs;
  List<Especialidad> list = [];

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
        final resp = await _citasMedicasProvider.listarEspecialidad();
        list = resp.datos;
      },
    );

    fetchingLoading.value = false;
  }

  void filterPromocion(String term) {
    update([gbList]);
  }

  Future<void> onItemTap(Especialidad item) async {
    _nuevaResevaX.setEspecialidad(item);

    await _keyX.closeKeyboardIfOpen();
    Get.toNamed(AppRoutes.SALUD_DOCTOR);
  }
}
