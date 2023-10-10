import 'dart:io';

import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';

class MiscPhotoZoomController extends GetxController {
  File? photoFile;

  @override
  void onInit() {
    super.onInit();

    _init();
  }

  void _init() {
    if (!(Get.arguments is MiscPhotoZoomArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as MiscPhotoZoomArguments;
    photoFile = arguments.photo;
  }
}

class MiscPhotoZoomArguments {
  final File photo;

  MiscPhotoZoomArguments({required this.photo});
}
