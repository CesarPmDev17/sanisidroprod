import 'package:app_san_isidro/data/models/zenbus_models.dart';
import 'package:app_san_isidro/modules/mi_bus/mi_bus_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParaderosBottomPanelController extends GetxController {
  final busX = Get.find<MiBusController>();

  final scrollCtlr = ScrollController();

  List<HorarioParaderoFeature> list = [];
  HorarioParaderoFeature? selected;

  final itemHeight = akFontSize * 4;
  Color mainColor = Colors.indigo;

  String rutaName = 'RUTA';

  @override
  void onInit() {
    super.onInit();
    list = busX.paraderos;
    selected = busX.paraderoSelected;

    mainColor = busX.rutaOrdenType == RutaOrdenType.odd
        ? busX.oddColor
        : busX.evenColor;

    if (busX.rutaSelected != null) {
      rutaName = busX.rutaSelected!.descripcion;
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollToSelected();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _scrollToSelected() async {
    await Future.delayed(Duration(milliseconds: 300));
    if (selected != null) {
      final idxSelected = list
          .indexWhere((item) => item.properties.id == selected?.properties.id);
      if (idxSelected > 0) {
        _scrollToItem(idxSelected);
      }
    }
  }

  void _scrollToItem(int index) {
    scrollCtlr.animateTo((itemHeight * index) - 35.0,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void returnParadero(HorarioParaderoFeature paradero) {
    Get.back(result: paradero);
  }

  void closePanel() {
    Get.back();
  }
}
