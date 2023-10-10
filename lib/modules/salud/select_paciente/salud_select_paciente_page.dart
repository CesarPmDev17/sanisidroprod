import 'package:app_san_isidro/modules/salud/lista/widgets/salud_title_scaffold.dart';
import 'package:app_san_isidro/modules/salud/select_paciente/salud_select_paciente_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaludSelectPacientePage extends StatelessWidget {
  final _conX = Get.put(SaludSelectPacienteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Content(
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: akContentPadding * 0.5),
                          ArrowBack(onTap: () => Get.back()),
                          SaludTitleScaffold(
                            title: 'Verifica tus datos',
                            subTitle: 'Se usarán para reservar la cita',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Content(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MetaData('Doc. identidad',
                            _conX.personaData.txtdocidentidad),
                        _MetaData(
                          'Tipo doc. identidad',
                          Helpers.capitalizeFirstLetter(
                              _conX.personaData.txttipodoc),
                        ),
                        _MetaData('Nombre de paciente',
                            Helpers.nameFormatCase(_conX.getFullName)),
                        SizedBox(height: 10.0),
                        _NoteMessage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child:
                Obx(() => _conX.loading.value ? LoadingOverlay() : SizedBox()),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          right: 4.0,
          bottom: 4.0,
        ),
        width: 55.0,
        height: 55.0,
        child: FittedBox(
          child: AkButton(
            backgroundColor: akPrimaryColor,
            borderRadius: 300.0,
            contentPadding: EdgeInsets.all(40.0),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: akFontSize * 10,
              color: akWhiteColor,
            ),
            onPressed: _conX.onContinueTap,
          ),
        ),
      ),
    );
  }
}

class _NoteMessage extends StatelessWidget {
  const _NoteMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
            decoration: BoxDecoration(
              color: akAccentColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: AkText(
              'Nota:',
              style: TextStyle(
                color: akPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          AkText(
            'Si los datos son correctos, selecciona el botón de continuar. De lo contrario, comunícate con soporte técnico.',
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class _MetaData extends StatelessWidget {
  final String title;
  final String description;

  const _MetaData(
    this.title,
    this.description, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AkText(
          this.title,
          textAlign: TextAlign.start,
          type: AkTextType.h9,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        AkText(
          this.description,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: akTextColor,
            fontSize: akFontSize + 2.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 18.0),
      ],
    );
  }
}
