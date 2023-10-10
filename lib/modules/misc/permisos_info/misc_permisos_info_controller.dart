import 'package:get/get.dart';

class MiscPermisosInfoController extends GetxController {
  String message = '';

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is MiscPermisosInfoArguments) {
      final arguments = Get.arguments as MiscPermisosInfoArguments;

      message = arguments.message;
    }
  }
}

class MiscPermisosInfoArguments {
  final String message;

  const MiscPermisosInfoArguments({required this.message});
}
