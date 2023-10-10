import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/pagos/inicio/pagos_inicio_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagosInicioPage extends StatelessWidget {
  final _conX = Get.put(PagosInicioController());
  final _authX = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          painter: BigHeaderCurvePainter(
                            // color: akPrimaryColor.withOpacity(.07),
                            color:
                                Helpers.darken(akScaffoldBackgroundColor, 0.03),
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
                        Content(child: ArrowBack(onTap: () => Get.back())),
                        SizedBox(height: Get.width * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FadeInDown(
                              delay: Duration(milliseconds: 400),
                              duration: Duration(milliseconds: 300),
                              from: 50,
                              child: CIconPagosTax(
                                size: Get.width * 0.60,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.width * 0.1),
                      ],
                    ),
                  )
                ],
              ),
              Content(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    AkText(
                      'Módulos',
                      style: TextStyle(
                        fontSize: akFontSize + 4.0,
                        fontWeight: FontWeight.w500,
                        color: akPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _authX.esContribuyente
                        ? _SectionContribuyente(_conX)
                        : AlertNoContribuyente(
                            padding: EdgeInsets.symmetric(
                                horizontal: akContentPadding,
                                vertical: Get.width * 0.15),
                            text:
                                'Esta opción es para vecinos contribuyentes de San Isidro',
                          ),
                    SizedBox(height: 20.0),
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
                          height: _authX.esContribuyente ? 160.0 : 60.0,
                          decoration: BoxDecoration(
                              // border: Border.all(color: Colors.red),
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionContribuyente extends StatelessWidget {
  final PagosInicioController conX;
  const _SectionContribuyente(this.conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _OptionItem(
          title: 'Deudas pendientes',
          subTitle: 'Obtén descuentos pagando tus tributos',
          iconData: Icons.monetization_on_outlined,
          onTap: conX.onDeudasPendientesTap,
        ),
        _OptionItem(
          title: 'Estado de cuenta',
          subTitle: 'Información detallada de tu estado de cuenta',
          iconData: Icons.insert_chart_outlined_rounded,
          onTap: conX.onEstadoCuentaTap,
        ),
        _OptionItem(
          title: 'Pagos realizados',
          subTitle: 'Histórico de tus pagos vía web o aplicación',
          iconData: Icons.add_task_rounded,
          onTap: conX.onPagosRealizadosTap,
        ),
        _OptionItem(
          title: 'Consulta de expedientes',
          subTitle: 'Información referentes a los expedientes',
          iconData: Icons.manage_search_rounded,
          onTap: conX.onConsultaExpedientesTap,
        ),
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconData;
  final void Function()? onTap;
  const _OptionItem(
      {Key? key,
      this.title = '',
      this.subTitle = '',
      this.iconData,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubbleSize = Get.width * 0.12;

    return Container(
      margin: EdgeInsets.only(bottom: akContentPadding * 0.65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: akWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B8D8D).withOpacity(.25),
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 2,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                onTap?.call();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(akContentPadding * 0.76),
                child: Row(
                  children: [
                    Container(
                      width: bubbleSize,
                      height: bubbleSize,
                      decoration: BoxDecoration(
                        color: akScaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(bubbleSize * 3),
                      ),
                      child: Icon(
                        iconData ?? Icons.donut_large_sharp,
                        size: bubbleSize * 0.5,
                        color: akAccentColor,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AkText(
                            title,
                            style: TextStyle(
                              color: akTitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: akFontSize + 1.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          AkText(
                            subTitle,
                            style: TextStyle(
                                fontSize: akFontSize - 1.0,
                                color: akTitleColor.withOpacity(.45)),
                          ),
                          SizedBox(height: 4.0),
                        ],
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
