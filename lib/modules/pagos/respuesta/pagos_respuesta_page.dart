import 'package:app_san_isidro/modules/pagos/respuesta/pagos_respuesta_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PagosRespuestaPage extends StatelessWidget {
  final _conX = Get.put(PagosRespuestaController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // IMPORTANTE: Evita que se pueda retroceder
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: akContentPadding * 1,
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Container(
                    width: Get.width * 0.85,
                    child: Lottie.asset(
                      "assets/lottie/${_conX.successPayment ? 'payment_successful' : 'payment_failed'}.json",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _CardData(_conX),
                  SizedBox(height: 30.0),
                  _conX.successPayment
                      ? AkButton(
                          enableMargin: false,
                          fluid: true,
                          onPressed: _conX.onVerConstanciaTap,
                          text: 'Ver constancia',
                        )
                      : SizedBox(),
                  SizedBox(height: _conX.successPayment ? 15.0 : 0.0),
                  AkButton(
                    fluid: true,
                    type: AkButtonType.outline,
                    onPressed: _conX.onCerrarTap,
                    text: 'Cerrar',
                  ),
                  SizedBox(height: _conX.successPayment ? 30.0 : 120.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardData extends StatelessWidget {
  final PagosRespuestaController conX;
  const _CardData(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: akContentPadding * .90,
        vertical: akContentPadding * 1.5,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B8D8D).withOpacity(.10),
            offset: Offset(0, 4),
            spreadRadius: 4,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          AkText(
            conX.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: akTitleColor,
              fontSize: akFontSize + 4.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.0),
          AkText(
            conX.subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: akTitleColor.withOpacity(1),
              fontSize: akFontSize + 1.0,
            ),
          ),
          SizedBox(height: 25.0),
          _FieldItem('Nro. pedido', conX.nroPedido),
          _FieldItem('Fecha', conX.fecha),
          conX.successPayment
              ? Column(
                  children: [
                    _FieldItem('Hora', conX.hora),
                    _FieldItem('Tarjeta', conX.nroTarjeta),
                    _FieldItem('Moneda', conX.moneda),
                    SizedBox(height: 10.0),
                    DottedLine(
                      dashLength: 4,
                      dashGapLength: 4,
                      lineThickness: 1,
                      dashColor: Color(0xFF707070).withOpacity(0.35),
                    ),
                    SizedBox(height: 10.0),
                    _FieldItem('Monto', conX.monto, valueBold: true),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class _FieldItem extends StatelessWidget {
  final String label;
  final String value;
  final bool valueBold;

  const _FieldItem(
    this.label,
    this.value, {
    Key? key,
    this.valueBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: AkText(
              label,
              style: TextStyle(
                color: akTitleColor.withOpacity(1),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            flex: 7,
            child: AkText(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: akTitleColor,
                fontWeight: valueBold ? FontWeight.w500 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
