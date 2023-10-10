import 'dart:convert';

import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/view_pdf/view_pdf_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class PruebaController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final recetaLoading = false.obs;

  Future<void> onVerRecetaTap() async {
    if (recetaLoading.value) return;

    recetaLoading.value = true;

    await tryCatch(
      code: () async {
        final _citasMedicasProvider = CitasMedicasProvider();
        final resp = await _citasMedicasProvider.recetaMedica(
          codReserva: '2022-0000001266',
        );

        if (resp.codigoRespuesta == '01') {
          final pdfB64 = resp.recetaBase64!;
          final pdfBytes = base64Decode(pdfB64);

          Get.toNamed(
            AppRoutes.VIEW_PDF,
            arguments: ViewPdfArguments(
              pageName: 'Receta Médica',
              pdfBytes: pdfBytes,
            ),
          );
        } else {
          AppSnackbar().warning(
            message: 'No hay una receta médica asociada a esta cita.',
          );
        }
      },
    );

    recetaLoading.value = false;
  }
}
