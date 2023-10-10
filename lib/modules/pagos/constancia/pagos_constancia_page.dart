import 'package:app_san_isidro/modules/pagos/constancia/pagos_constancia_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PagosConstanciaPage extends StatelessWidget {
  final _conX = Get.put(PagosConstanciaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Content(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    AppBarTitle('Constancia de pago'),
                  ],
                ),
              ),
            ),
            SizedBox(height: akContentPadding * 0.35),
            Expanded(
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      child: GetBuilder<PagosConstanciaController>(
                        id: _conX.gbPdfViewer,
                        builder: (_) {
                          if (_conX.pdfController != null) {
                            return PdfView(
                              controller: _conX.pdfController!,
                              scrollDirection: Axis.vertical,
                              backgroundDecoration: BoxDecoration(
                                color: Helpers.darken(
                                  akScaffoldBackgroundColor,
                                  0.04,
                                ),
                              ),
                              pageSnapping: false,
                              onPageChanged: _conX.onPageChanged,
                              onDocumentLoaded: _conX.onDocumentLoaded,
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      )),
                  _PageCounter(_conX),
                  _LoadingBuilder(_conX)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PageCounter extends StatelessWidget {
  final PagosConstanciaController conX;

  const _PageCounter(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: akContentPadding * 0.75,
      right: akContentPadding * 0.75,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(.65),
            borderRadius: BorderRadius.circular(4.0)),
        child: Obx(
          () => AkText(
            '${conX.currentPage}/${conX.pagesCount}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingBuilder extends StatelessWidget {
  final PagosConstanciaController conX;
  const _LoadingBuilder(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Obx(
        () => AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: conX.pdfLoading.value
              ? LoadingOverlay(
                  opacityNumber: 1,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
