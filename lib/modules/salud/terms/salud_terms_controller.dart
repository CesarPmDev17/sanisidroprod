import 'package:get/get.dart';

class SaludTermsController extends GetxController {
  void onRejectTap() {
    Get.back(result: false);
  }

  void onAcceptTap() {
    Get.back(result: true);
  }
}
