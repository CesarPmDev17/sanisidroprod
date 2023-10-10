import 'package:app_san_isidro/data/models/vecino_comunica.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class VecinoComunicaSuccessController extends GetxController {
  VcCasoCreateResponse? data;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  Future<void> _init() async {
    if (!(Get.arguments is VecinoComunicaSuccessArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as VecinoComunicaSuccessArguments;
    data = arguments.data;
  }
}

class VecinoComunicaSuccessArguments {
  final VcCasoCreateResponse data;

  VecinoComunicaSuccessArguments({required this.data});
}
