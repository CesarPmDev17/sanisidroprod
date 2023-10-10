import 'package:app_san_isidro/modules/salud/detalle/salud_detalle_controller.dart';
import 'package:app_san_isidro/modules/salud/lista/widgets/cita_avatar.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaludDetallePage extends StatelessWidget {
  final _args = Get.arguments as SaludDetalleArguments;
  late final _conX = Get.put(SaludDetalleController(_args.cita));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1 / 2,
                            child: CustomPaint(
                              painter: BigHeaderColorCurvePainter(
                                color: akPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: akContentPadding * 0.5),
                            Row(
                              children: [
                                SizedBox(width: akContentPadding),
                                ArrowBack(
                                  onTap: () => Get.back(),
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: AkText(
                                    'Detalle de cita',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.70),
                                      fontSize: akFontSize + 1.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Get.width * 0.11),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: akContentPadding * 2.0,
                              ),
                              child: AkText(
                                _conX.cita.fechaCitaString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: akFontSize + 17.0,
                                  height: 1.7,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.width * 0.22),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: akContentPadding * 3,
                    bottom: -35.0,
                    child: CitaAvatar(
                      size: 80.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: akContentPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AkText(
                      _conX.cita.txtespecialidad,
                      style: TextStyle(
                        color: akPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: akFontSize + 1.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    AkText(
                      'Dr.\n${Helpers.nameFormatCase(_conX.cita.txtpersonasalud)}',
                      style: TextStyle(
                        color: akTitleColor,
                        fontSize: akFontSize + 4.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Content(child: _NoteWidget()),
              Expanded(child: SizedBox(height: 30.0)),
              if (_conX.isVirtual)
                Obx(
                  () => Content(
                    child: AkButton(
                      enableMargin: false,
                      onPressed: _conX.onEnterRoomTap,
                      contentPadding: EdgeInsets.all(14.0),
                      backgroundColor: akAccentColor,
                      fluid: true,
                      child: _conX.loading.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpinLoadingIcon(
                                  size: akFontSize * 1.5,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.videocam_rounded,
                                  color: akWhiteColor,
                                  size: akFontSize + 8.0,
                                ),
                                SizedBox(width: 10.0),
                                Flexible(
                                  child: AkText(
                                    'Unirse a la llamada',
                                    style: TextStyle(
                                      color: akWhiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: akFontSize + 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              SizedBox(height: 15.0),
              Content(child: _ButtonVerReceta(_conX)),
              SizedBox(height: akContentPadding),
            ],
          ),
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

class _ButtonVerReceta extends StatelessWidget {
  const _ButtonVerReceta(this._conX, {Key? key}) : super(key: key);

  final SaludDetalleController _conX;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AkButton(
        fluid: true,
        onPressed: _conX.onVerRecetaTap,
        enableMargin: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _conX.recetaLoading.value
                ? SpinLoadingIcon(
                    size: akFontSize + 2.0,
                  )
                : AkText(
                    'Ver receta',
                    style: TextStyle(
                      color: akWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
