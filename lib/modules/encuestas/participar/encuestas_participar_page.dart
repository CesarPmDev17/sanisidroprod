import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/encuesta.dart';
import 'package:app_san_isidro/modules/encuestas/components/poll_item_card.dart';
import 'package:app_san_isidro/modules/encuestas/participar/encuestas_participar_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EncuestasParticiparPage extends StatelessWidget {
  final _conX = Get.put(EncuestasParticiparController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
      child: Scaffold(
        body: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    ArrowBack(onTap: () async {
                      if (await _conX.handleBack()) Get.back();
                    }),
                    AppBarTitle('Participar'),
                    SizedBox(height: 12.0),
                    Obx(
                      () => _conX.fetchingData.value
                          ? _LoadingSection()
                          : FadeIn(
                              duration: Duration(milliseconds: 300),
                              child: _Body(_conX),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.15),
      child: LoadingOverlay(
        text: 'Cargando formulario...',
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final EncuestasParticiparController _conX;

  const _Body(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PollItemCard(_conX.encuesta, _conX.directoryApp, showButton: false),
        SizedBox(height: 20.0),
        GetBuilder<EncuestasParticiparController>(
          id: _conX.gbPreguntas,
          builder: (_) => _QuestionItemList(_conX),
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Expanded(
              child: FadeInLeft(
                duration: Duration(milliseconds: 200),
                child: AkButton(
                  type: AkButtonType.outline,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  onPressed: () async {
                    if (await _conX.handleBack()) Get.back();
                  },
                  text: 'Cancelar',
                  borderRadius: 300,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: FadeInRight(
                duration: Duration(milliseconds: 200),
                child: AkButton(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  onPressed: _conX.onButtonSendTap,
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                              duration: Duration(milliseconds: 150),
                              child: _conX.sendLoading.value
                                  ? SpinLoadingIcon(size: akFontSize + 2.5)
                                  : AkText(
                                      'Enviar',
                                      style: TextStyle(
                                        color: akWhiteColor,
                                      ),
                                    )),
                        ],
                      )),
                  borderRadius: 300,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }
}

class _QuestionItemList extends StatelessWidget {
  final EncuestasParticiparController _conX;

  const _QuestionItemList(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_QuestionItem> items = [];

    _conX.preguntas.forEach((e) {
      items.add(_QuestionItem(
        e,
        _conX.directoryApp,
        onOptionTap: _conX.onOptionTap,
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items,
      ],
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final Opcion pregunta;
  final Directory directory;
  final void Function(int codPregunta, int codOpcion) onOptionTap;

  _QuestionItem(this.pregunta, this.directory, {required this.onOptionTap});

  Widget itemAlternativas() {
    List<Widget> list = [];
    for (var i = 0; i < pregunta.alternativas.length; i++) {
      Alternativa alternativa = pregunta.alternativas[i];

      File? imagenAlternativa;
      if (alternativa.archivoIcono != null &&
          Helpers.checkIfDataBase64IsImage(alternativa.archivoIcono!)) {
        imagenAlternativa = File(directory.path +
            '/encuesta_alternativa_${pregunta.codEncuesta}_${pregunta.codEncuestaPregunta}_${alternativa.codOpcion}.png');
        imagenAlternativa
          ..writeAsBytesSync(
              Helpers.getDecodedBytes(alternativa.archivoIcono!));
      }

      list.add(_AlternativaButton(
        imageFile: imagenAlternativa,
        text: alternativa.opcion,
        selected: alternativa.seleccionado,
        onTap: () {
          onOptionTap.call(pregunta.codEncuestaPregunta, alternativa.codOpcion);
        },
      ));
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: IntrinsicHeight(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...list,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AkText(
              '${pregunta.numOrden}. ',
              style: TextStyle(
                color: akTitleColor,
                fontSize: akFontSize + 2.0,
              ),
            ),
            Expanded(
              child: AkText(
                pregunta.pregunta,
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 2.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        itemAlternativas(),
        SizedBox(height: 35.0),
      ],
    );
  }
}

class _AlternativaButton extends StatelessWidget {
  final File? imageFile;
  final String text;
  final void Function()? onTap;
  final bool selected;

  const _AlternativaButton({
    Key? key,
    required this.imageFile,
    required this.text,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radiusOption = BorderRadius.all(Radius.circular(6.00));
    final selectedColor = akAccentColor;

    return Expanded(
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        borderRadius: radiusOption,
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          padding: EdgeInsets.all(4.00),
          decoration: imageFile == null
              ? BoxDecoration(
                  border: Border.all(
                    color: selected ? selectedColor : Colors.transparent,
                    width: 2.0,
                  ),
                  borderRadius: radiusOption,
                )
              : null,
          child: imageFile != null
              ? Container(
                  decoration: imageFile != null
                      ? BoxDecoration(
                          border: Border.all(
                            color:
                                selected ? selectedColor : Colors.transparent,
                            width: 2.0,
                          ),
                          borderRadius: radiusOption,
                        )
                      : null,
                  padding: EdgeInsets.all(3.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 30.0,
                      maxWidth: 30.0,
                    ),
                    child: Container(
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              : AkText(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: akFontSize - 2.0,
                    color: akPrimaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
