import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:get/get.dart';

class SaludIntroController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSkipTap() {
    Get.toNamed(AppRoutes.SALUD_LISTA);
  }

  Future<bool> handleBack() async {
    return true;
  }
}
