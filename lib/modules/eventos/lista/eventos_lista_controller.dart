import 'package:app_san_isidro/data/models/lugar.dart';
import 'package:app_san_isidro/data/models/tipo_lugar.dart';
import 'package:app_san_isidro/data/providers/eventos_lugares_provider.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class EventosListaController extends GetxController {
  // Instances
  final evlugProvider = EventosLugaresProvider();

  final fetchingTipos = true.obs;
  final fetchingEventos = true.obs;

  // Tipo de lugares
  List<TipoLugar> tipos = [];
  String codigoTipoSelected = '';
  final gbTiposList = 'gbTiposList';

  // lugares
  List<Lugar> lugares = [];

  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    await Helpers.sleep(600);
    fetchingEventos.value = false;
  }

  Future<bool> handleBack() async {
    return true;
  }
}
