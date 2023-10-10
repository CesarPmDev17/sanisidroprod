import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpedientesBuscadorPage extends StatelessWidget {
  // final _conX = Get.put(VPSIMiTarjetaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: _buildContent(constraints),
            physics: BouncingScrollPhysics(),
          );
        },
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: Get.width * 0.05,
                          right: -Get.width * 0.065,
                          child: RoundedDiamondsOutline(
                            size: Get.width * 0.25,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 160.0,
                          /* decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)), */
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () => Get.back()),
                    Expanded(child: SizedBox()),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AkText(
                            'Consulta\nexpedientes',
                            style: TextStyle(
                              color: akTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: akFontSize + 16.0,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          AkText(
                            'Escribe el código del expediente',
                            style: TextStyle(
                              fontSize: akFontSize + 4.0,
                            ),
                          ),
                          SizedBox(height: 28.0),
                          SearchInput(isBig: true),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.0),
                    Expanded(child: SizedBox()), // No quitar
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
