import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_san_isidro/data/providers/pagos_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/misc/error/misc_error_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';

class PagosEstadoCuentaController extends GetxController {
  // Instances
  late PagosEstadoCuentaController _self;
  final _authX = Get.find<AuthController>();
  final _pagosProvider = PagosProvider();

  PdfController? pdfController;

  final pdfLoading = true.obs;

  // Getbuilder ID's
  final gbPdfViewer = 'gbPdfViewer';

  final pagesCount = 0.obs;
  final currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _self = this;

    _fetchData();
  }

  Future<void> _fetchData() async {
    String? errorMsg;
    try {
      await Helpers.sleep(400);
      final path = await loadPdf();
      if (_self.isClosed) return;
      pdfController = PdfController(document: PdfDocument.openFile(path));
      update([gbPdfViewer]);
      await Helpers.sleep(400);
    } on ApiException catch (e) {
      errorMsg = e.message;
      Helpers.logger.e(e.message);
    } catch (e) {
      errorMsg =
          'Ocurrió un error inesperado recuperando la información de estado de cuenta.';
      Helpers.logger.e(e.toString());
    }

    if (_self.isClosed) return;
    if (errorMsg != null) {
      final ers = await Get.toNamed(AppRoutes.MISC_ERROR,
          arguments: MiscErrorArguments(content: errorMsg));

      if (ers == MiscErrorResult.retry) {
        await Helpers.sleep(2500);
        _fetchData();
      } else {
        Get.back();
      }
    } else {
      pdfLoading.value = false;
    }
  }

  // ******** FUNCIONES DE PDF VIEWER **********
  void onDocumentLoaded(PdfDocument pdf) {
    pagesCount.value = pdf.pagesCount;
  }

  void onPageChanged(int i) {
    currentPage.value = i;
  }

  // ******** FUNCIONES PARA DESCARGAR EL ARCHIVO **********
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/last_estado_cuenta.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPDF() async {
    final response = await _pagosProvider.fetchEstadoCuentaPdf(
      codContribuyente: _authX.personaStored!.codContribuyente,
    );
    return response;
  }

  Future<String> loadPdf() async {
    await writeCounter(await fetchPDF());

    return (await _localFile).path;
  }
}
