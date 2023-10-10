import 'dart:io';
import 'dart:typed_data';

import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:path_provider/path_provider.dart';

class ViewPdfViewController extends GetxController {
  final String pageName;
  final Uint8List? pdfBytes;
  final String? urlPDF;

  String pdfName = '';

  ViewPdfViewController(
      {required this.pageName, required this.pdfBytes, required this.urlPDF});

  // Instances
  late ViewPdfViewController _self;
  PdfController? pdfController;

  final pdfLoading = true.obs;

  // Getbuilder ID's
  final gbPdfViewer = 'gbPdfViewer';

  final pagesCount = 0.obs;
  final currentPage = 1.obs;

  String codReciboPagado = '';

  @override
  void onInit() {
    super.onInit();
    _self = this;

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (pdfBytes == null && urlPDF == null) {
        AppSnackbar().error(message: 'No se está enviando la fuente del PDF');
        return;
      }

      _fetchData();
    });
  }

  Future<void> _fetchData() async {
    await Helpers.sleep(400);
    await tryCatch(
      code: () async {
        String path = '';
        if (pdfBytes != null) {
          pdfName = 'file_cached.pdf';

          path = await loadPdf(pdfBytes!);
        } else {
          final uriPath = Uri.parse(urlPDF!);
          pdfName = uriPath.pathSegments.last;

          path = await loadPdf(null);
        }

        if (_self.isClosed) return;
        pdfController = PdfController(document: PdfDocument.openFile(path));
        update([gbPdfViewer]);
        await Helpers.sleep(400);
      },
      onCancelRetry: () async {
        Get.back();
      },
    );

    pdfLoading.value = false;
  }

  // ******** FUNCIONES DE PDF VIEWER **********
  void onDocumentLoaded(PdfDocument pdf) {
    pagesCount.value = pdf.pagesCount;
  }

  void onPageChanged(int i) {
    currentPage.value = i;
  }

  // ******** FUNCIONES PARA DESCARGAR EL ARCHIVO **********
  Future<String> loadPdf(Uint8List? stream) async {
    await writeCounter(stream ?? await fetchPDF());

    return (await _localFile).path;
  }

  Future<Uint8List> fetchPDF() async {
    final Dio dio = Dio();
    final client = DioClient('', dio);
    final resp = await client.get(
      urlPDF!,
      options: Options(responseType: ResponseType.bytes),
    );
    final responseBytes = resp as List<int>;
    return responseBytes as Uint8List;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$pdfName');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;
    return file.writeAsBytes(stream);
  }
}

class ViewPdfArguments {
  final String pageName;
  final Uint8List? pdfBytes;
  final String? urlPDF;

  const ViewPdfArguments({
    required this.pageName,
    this.pdfBytes,
    this.urlPDF,
  });
}
