import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class PagosTotalArguments {
  final String total;

  PagosTotalArguments({required this.total});
}

class PagosTotalController extends GetxController {
  final agreeTerms = true.obs;
  String total = '0.00';

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  void _init() {
    if (!(Get.arguments is PagosTotalArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as PagosTotalArguments;
    total = arguments.total;
  }

  void toggleTerms() {
    agreeTerms.value = !agreeTerms.value;
  }
}
