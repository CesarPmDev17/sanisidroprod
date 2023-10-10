import 'package:app_san_isidro/data/models/museo.dart';
import 'package:app_san_isidro/modules/home/home_controller.dart';
import 'package:get/get.dart';

class MuseoListaController extends GetxController {
  final _homeX = Get.find<HomeController>();
  List<Museo> museos = [];

  @override
  void onInit() {
    super.onInit();

    museos = _homeX.museosFull;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
