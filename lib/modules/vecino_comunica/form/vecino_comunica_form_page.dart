import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/modules/vecino_comunica/form/vecino_comunica_form_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VecinoComunicaFormPage extends StatelessWidget {
  final _conX = Get.put(VecinoComunicaFormController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: _buildContent(constraints),
              physics: BouncingScrollPhysics(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: akContentPadding * 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ArrowBack(onTap: () async {
                          if (await _conX.handleBack()) Get.back();
                        }),
                        Flexible(
                          child: _ButtonMyCases(
                            onTap: _conX.onButtonMyCasesTap,
                          ),
                        ),
                      ],
                    ),
                    AppBarTitle('Vecino\ncomunica'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Obx(
                () => AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _conX.fetchLoading.value
                      ? _LoadingLayer()
                      : Content(
                          child: _FormSection(conX: _conX),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonMyCases extends StatelessWidget {
  final void Function() onTap;

  const _ButtonMyCases({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      onTap: this.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: AkText(
                'Mis casos',
                style: TextStyle(
                  color: akPrimaryColor,
                  fontSize: akFontSize + 2.0,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Icon(
              Icons.format_list_bulleted_rounded,
            )
          ],
        ),
      ),
    );
  }
}

class _LoadingLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Content(
      fluid: true,
      child: Center(
        child: Transform.translate(
          offset: Offset(0, -80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinLoadingIcon(
                color: akPrimaryColor,
                size: akFontSize + 8.0,
              ),
              SizedBox(height: 10.0),
              AkText(
                'Cargando...',
                style: TextStyle(
                  color: akPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final VecinoComunicaFormController conX;

  const _FormSection({Key? key, required this.conX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: AkText(
                'Asunto',
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            AkText(
              '*',
              style: TextStyle(
                color: akRedColor,
                fontSize: akFontSize + 2.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 5.0),
        GetBuilder<VecinoComunicaFormController>(
            id: conX.gbOptionSelector,
            builder: (_) {
              List<Widget> options = [];
              conX.motivosList.forEach((item) {
                options.add(_RadioOption(
                  code: item.codMotivo,
                  text: Helpers.capitalizeFirstLetter(item.motivo),
                  isSelected: item.codMotivo == conX.codigoCasoSelected,
                  onTap: conX.setOptionSelected,
                ));
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...options],
              );
            }),
        SizedBox(height: 25.0),
        Row(
          children: [
            Flexible(
              child: AkText(
                'Descripción',
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            AkText(
              '*',
              style: TextStyle(
                color: akRedColor,
                fontSize: akFontSize + 2.0,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 15.0),
        AkInput(
          type: AkInputType.legend,
          filledColor: Color(0xFFA7A7A7).withOpacity(.12),
          filledFocusedColor: Color(0xFFA7A7A7).withOpacity(.12),
          enabledBorderColor: Colors.transparent,
          focusedBorderColor: Colors.transparent,
          hintText: 'Escribir un comentario',
          labelColor: akTitleColor.withOpacity(.25),
          enableClean: false,
          onChanged: (val) => conX.descripcion = val.trim(),
          maxLines: 4,
          maxLength: 300,
        ),
        SizedBox(height: 25.0),
        /* AkText(
          'Archivos adjuntos',
          style: TextStyle(
            color: akTitleColor,
            fontSize: akFontSize + 2.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.0),
        Obx(() => _buildAttachments(conX.photoList)), */
        Row(
          children: [
            AkText(
              '(*) Campos requeridos.',
              style: TextStyle(
                color: akRedColor,
                fontSize: akFontSize - 2.0,
              ),
            )
          ],
        ),
        SizedBox(height: 25.0),
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
                    if (await conX.handleBack()) Get.back();
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
                  onPressed: conX.onButtonSendTap,
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                              duration: Duration(milliseconds: 150),
                              child: conX.sendLoading.value
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

  /* Widget _buildAttachments(Map<int, File> itemList) {
    final Iterable<MapEntry<int, File>> photos = itemList.entries;

    List<PhotoItem> items = [];

    for (var photo in photos) {
      items.add(PhotoItem(
        file: photo.value,
        onRemoveTap: () => conX.removePhotoFromList(photo.key),
        onPhotoTap: () async {
          Get.toNamed(
            AppRoutes.MISC_PHOTO_ZOOM,
            arguments: MiscPhotoZoomArguments(photo: photo.value),
          );
        },
      ));
    }

    // Número máximo de fotos.
    // La versión 2.X de la app solo aceptaba 1 archivo adjunto
    if (photos.length < 1) {
      items.add(PhotoItem(
        onCameraTap: () => conX.addPhotoToList(fromCamera: true),
        onGalleryTap: () => conX.addPhotoToList(fromCamera: false),
      ));
    }

    return Container(
      height: 100,
      child: GridView.count(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        shrinkWrap: true,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: items,
      ),
    );
  } */
}

class _RadioOption extends StatelessWidget {
  final String code;
  final String text;
  final bool isSelected;
  final void Function(String)? onTap;

  _RadioOption({
    required this.code,
    this.text = '',
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6.0),
      onTap: () {
        onTap?.call(code);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            SizedBox(width: akContentPadding),
            _RadioCircle(isSelected: isSelected),
            SizedBox(width: 18),
            Expanded(child: AkText(text)),
          ],
        ),
      ),
    );
  }
}

class _RadioCircle extends StatelessWidget {
  final double size;
  final bool isSelected;

  _RadioCircle({this.size = 9.0, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.20),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? akPrimaryColor : akTitleColor.withOpacity(.40),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(size * 2),
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isSelected ? akPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(size),
        ),
      ),
    );
  }
}
