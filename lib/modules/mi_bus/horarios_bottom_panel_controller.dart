import 'package:app_san_isidro/data/models/zenbus_models.dart';
import 'package:app_san_isidro/modules/mi_bus/mi_bus_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:get/get.dart';

class HorariosBottomPanelController extends GetxController {
  final busX = Get.find<MiBusController>();

  HorarioParaderoFeature? selected;

  final itemHeight = akFontSize * 4;
  String paraderoName = 'Paradero name';

  @override
  void onInit() {
    super.onInit();
    selected = busX.paraderoSelected;

    if (selected != null) {
      paraderoName = selected!.properties.descripcion;
    }
  }

  void closePanel() {
    Get.back();
  }
}
