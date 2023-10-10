import 'package:app_san_isidro/data/models/central_telefonica.dart';
import 'package:app_san_isidro/modules/telefonos_emergencia/data/directorio_store.dart';
import 'package:get/get.dart';

class TelefonosEmergenciaController extends GetxController {
  final List<CentralCategoria> directorio = directorioStore;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
