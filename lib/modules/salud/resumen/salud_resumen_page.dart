import 'package:app_san_isidro/data/models/nueva_reserva_cita.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/modules/salud/resumen/salud_resumen_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludResumenPage extends StatelessWidget {
  final _conX = Get.put(SaludResumenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Obx(
            () => SingleChildScrollView(
              child: _buildContent(constraints, _conX.loading.value),
              physics: BouncingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints, bool isLoading) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Column(
              children: [
                Content(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: akContentPadding * 0.5),
                        ArrowBack(onTap: () => Get.back()),
                        SaludTitleScaffold(
                          title: 'Resumen,',
                          subTitle: 'de los datos seleccionados',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _ResumenBody(_conX),
                )
              ],
            ),
            if (isLoading)
              Positioned.fill(
                child: LoadingOverlay(),
              )
          ],
        ),
      ),
    );
  }
}

class _ResumenBody extends StatelessWidget {
  const _ResumenBody(
    this._conX, {
    Key? key,
  }) : super(key: key);

  final SaludResumenController _conX;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(akContentPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // _DataTitle('Tarifa de cita (pago presencial)'),
                    // _DataDescription('S/ ${_conX.data?.numimporte ?? ''}'),
                    _DataTitle('Tipo de reunión'),
                    _DataDescription(
                      _conX.tipoReserva == TipoNuevaReservaCita.virtual
                          ? 'VIRTUAL'
                          : 'PRESENCIAL',
                    ),
                    _DataTitle('Especialidad'),
                    _DataDescription(_conX.data?.txtespecialidad ?? ''),
                    _DataTitle('Doctor'),
                    _DataDescription('${_conX.data?.txtpersonasalud ?? ''}'),
                    _DataTitle('Paciente'),
                    _DataDescription(_conX.getFullName),
                    _DataTitle('Fecha de cita'),
                    _DataDescription(_conX.getFechaFormated()),
                    _NoteWidget(),
                    SizedBox(height: 10.0),
                    // Habilitar cuando se soliciten pagos
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: _conX.onCheckTermsTap,
                    //       child: Container(
                    //         padding: EdgeInsets.all(akContentPadding * 0.5),
                    //         child: Obx(
                    //           () => CustomCheckbox(
                    //             isSelected: _conX.agreeTerms.value,
                    //             enabled: true,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10.0),
                    //     Flexible(
                    //       child: GestureDetector(
                    //         onTap: _conX.onTermsLabelTap,
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(
                    //             vertical: 7.0,
                    //           ),
                    //           child: AkText(
                    //             'Ver términos y condiciones',
                    //             style: TextStyle(
                    //               decoration: TextDecoration.underline,
                    //               color: akTitleColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20.0),
                  ],
                ),
                AkButton(
                  fluid: true,
                  onPressed: _conX.onPagarTap,
                  enableMargin: false,
                  text: 'RESERVAR',
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DataTitle extends StatelessWidget {
  final String text;

  _DataTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      child: AkText(
        text,
        type: AkTextType.subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: akFontSize,
        ),
      ),
    );
  }
}

class _DataDescription extends StatelessWidget {
  final String text;

  _DataDescription(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: AkText(
        text,
        style: TextStyle(
          fontSize: akFontSize + 1.0,
        ),
      ),
    );
  }
}

class _NoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: akPrimaryColor.withOpacity(.09),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/chat.svg',
            color: akPrimaryColor,
            width: akFontSize + 12.0,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AkText(
                  'Asistir con 15 minutos de anticipación.',
                  style: TextStyle(
                    color: akPrimaryColor,
                  ),
                ),
                SizedBox(height: 10.0),
                AkText(
                  'No hay tiempo de tolerancia',
                  style: TextStyle(
                    color: akPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
