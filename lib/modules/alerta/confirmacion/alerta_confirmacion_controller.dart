import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class AlertaConfirmacionController extends GetxController {
  String numeroCaso = '';

  @override
  void onInit() {
    super.onInit();

    if (!(Get.arguments is AlertaConfirmacionArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as AlertaConfirmacionArguments;
    numeroCaso = arguments.numeroCaso;
  }
}

class AlertaConfirmacionArguments {
  final String numeroCaso;

  AlertaConfirmacionArguments({required this.numeroCaso});
}
