import 'package:app_san_isidro/modules/pagos/total/pagos_total_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PagosTotalPage extends StatelessWidget {
  final _conX = Get.put(PagosTotalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Content(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: akContentPadding * 0.5),
                ArrowBack(onTap: () => Get.back()),
                AppBarTitle('Total'),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AkText(
                      'S/ ${_conX.total}',
                      style: TextStyle(
                        fontSize: akFontSize + 16.0,
                        color: akTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    AkText(
                      'Monto a Pagar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    DottedLine(
                      dashLength: 4,
                      dashGapLength: 4,
                      lineThickness: 1,
                      dashColor: Color(0xFF707070).withOpacity(0.19),
                    ),
                    SizedBox(height: 20.0),
                    AkText(
                      '202102549',
                      style: TextStyle(
                        color: akTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    AkText(
                      '# de Orden',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    DottedLine(
                      dashLength: 4,
                      dashGapLength: 4,
                      lineThickness: 1,
                      dashColor: Color(0xFF707070).withOpacity(0.19),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shield_ok.svg',
                          color: akTitleColor.withOpacity(.15),
                          width: akFontSize + 8.0,
                        ),
                        SizedBox(width: 5.0),
                        Opacity(
                          opacity: .35,
                          child: Column(
                            children: [
                              AkText(
                                'Pago seguro',
                                style: TextStyle(fontSize: akFontSize - 4.0),
                              ),
                              AkText(
                                'y protegido',
                                style: TextStyle(fontSize: akFontSize - 4.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _MainButton(_conX),
    );
  }
}

class _MainButton extends StatelessWidget {
  final PagosTotalController _conX;

  _MainButton(this._conX);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _conX.toggleTerms,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Content(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: CustomCheckbox(
                        isSelected: _conX.agreeTerms.value,
                        enabled: true,
                      ))),
                  SizedBox(width: 12.0),
                  Expanded(
                      child: AkText(
                    'Acepto los Términos y Condiciones de pagos San Isidro.',
                    style: TextStyle(
                      color: akTitleColor,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
              color: akAccentColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(11.0))),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
              onTap: () {
                print('asdfsf');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 19.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AkText(
                        'CONFIRMAR Y PAGAR',
                        style: TextStyle(
                          color: akWhiteColor,
                          fontSize: akFontSize + 4.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
