import 'dart:async';

import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class KeyboardController extends GetxController {
  final keyboardVisibilityController = KeyboardVisibilityController();

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  void _init() {
    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      // Es necesario utilizar esta subscripción para que funcione correctamente
    });
  }

  @override
  void onClose() {
    keyboardSubscription.cancel();

    super.onClose();
  }

  Future<void> closeKeyboardIfOpen() async {
    if (keyboardVisibilityController.isVisible) {
      Get.focusScope?.unfocus();
      await Helpers.sleep(300);
    }
  }
}
