import 'dart:convert';

import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/data/providers/citas_medicas_provider.dart';
import 'package:app_san_isidro/modules/salud/videocall/salud_videocall_controller.dart';
import 'package:app_san_isidro/modules/view_pdf/view_pdf_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:get/get.dart';

class SaludDetalleController extends GetxController {
  SaludDetalleController(this.cita);
  final CitaReserva cita;

  late SaludDetalleController _self;

  final _citasMedicasProvider = CitasMedicasProvider();

  final enableJoinRoom = false.obs;

  bool _isVirtual = false;
  bool get isVirtual => this._isVirtual;

  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _isVirtual = cita.txttipopagoreserva == 'VIRTUAL';
  }

  @override
  void onClose() {
    super.onClose();
  }

  final recetaLoading = false.obs;
  Future<void> onEnterRoomTap() async {
    if (loading.value) return;
    loading.value = true;
    await tryCatch(
      self: _self,
      code: () async {
        await Helpers.sleep(800);
        final updatedCita =
            await _citasMedicasProvider.listarReservasPorId(cita.codreserva);
        if (updatedCita.codsala == null || updatedCita.txttoken == null) {
          Helpers.showError('El doctor aún no ha iniciado a la sala.');
          return;
        }
        Get.toNamed(AppRoutes.SALUD_VIDEOCALL,
            arguments: SaludVideoCallArguments(updatedCita));
      },
    );
    loading.value = false;
  }

  Future<void> onVerRecetaTap() async {
    if (recetaLoading.value) return;
    recetaLoading.value = true;
    await tryCatch(
      code: () async {
        final _citasMedicasProvider = CitasMedicasProvider();
        final resp = await _citasMedicasProvider.recetaMedica(
          codReserva: cita.codreserva,
        );

        if (resp.codigoRespuesta == '01') {
          final pdfB64 = resp.recetaBase64!;
          final pdfBytes = base64Decode(pdfB64);

          if (_self.isClosed) return;
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

class SaludDetalleArguments extends GetxController {
  final CitaReserva cita;
  SaludDetalleArguments(this.cita);
}
