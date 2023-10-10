import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/data/providers/ambulancia_provider.dart';
import 'package:app_san_isidro/modules/auth/auth_controller.dart';
import 'package:app_san_isidro/modules/home/home_page.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/webview_wrapper.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategSaniContigoPage extends StatefulWidget {
  @override
  State<CategSaniContigoPage> createState() => _CategSaniContigoPageState();
}

class _CategSaniContigoPageState extends State<CategSaniContigoPage> {
  final _authX = Get.find<AuthController>();
  final _ambulanciaLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final double iconSize = 29.0;

    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _Header(),
            _BigSection(
              title: 'SALUD',
              textColor: Colors.white,
              bgColor: const Color(0xFF586E28),
              children: [
                Category2Item(
                  text: 'Citas Médicas',
                  textFontWeight: FontWeight.w700,
                  iconBuilder: (focus) => CIconSaniContigov2_2(
                    size: iconSize + 15.0,

                  ),

                  bgColor: Colors.white,
                  onTap: () {
                    if (_authX.isGuest) {
                      Helpers.showGuestForbiddenAlert();
                      return;
                    }

                    Get.toNamed(AppRoutes.SALUD_INTRO);
                  },
                ),
                Category2Item(
                  text: 'Centro de Salud',
                  textFontWeight: FontWeight.w700,
                  bgColor: Colors.white,
                  iconBuilder: (focus) =>
                      CIconCentroSaludv2(size: 81, height: 50,),
                  onTap: () {
                    Get.toNamed(AppRoutes.CENTROS_SALUD);
                  },
                ),
                Category2Item(
                  text: 'Solicitar Ambulancia',
                  textFontWeight: FontWeight.w700,
                  iconBuilder: (focus) => Obx(
                    () => _ambulanciaLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(5),
                            child: SpinLoadingIcon(
                              strokeWidth: 2.0,
                              size: akFontSize + 6.0,
                            ),
                          )
                        : CIconAmbulancev2(
                            size: 80,
                            height: 50,
                          ),
                  ),

                  bgColor: Colors.white,
                  onTap: () {
                    if (_authX.isGuest) {
                      Helpers.showGuestForbiddenAlert();
                      return;
                    }

                    this._onAmbulanciaTap.call();
                  },
                ),
              ],
            ),
            _BigSection(
              title: 'DEPORTES',
              textColor: const Color(0xFF586E28),
              cover: 'assets/img/runsaludv2.png',
              bgColor: Color(0xFFd1d3d4),
              children: [
                Category2Item(
                  text: 'Reserva una cancha',
                  textFontWeight: FontWeight.w700,
                  iconBuilder: (focus) => CIconStadiumv2(
                    size: 80,
                    height: 50,
                  ),
                  textColor: akWhiteColor,
                  bgColor: akPrimaryColor,
                  boxShadowColor: Colors.white,
                  onTap: () {
                    if (_authX.isGuest) {
                      Helpers.showGuestForbiddenAlert();
                      return;
                    }

                    _openModuleInWebview(_PlatVirtualModule.cancha);
                  },
                ),
                Category2Item(
                  text: 'Reserva el gimnasio',
                  textFontWeight: FontWeight.w700,
                  textColor: akWhiteColor,
                  bgColor: akPrimaryColor,
                  boxShadowColor: Colors.white,
                  iconBuilder: (focus) => CIconGymv2(size: 80,
                    height: 50,),
                  onTap: () {
                    if (_authX.isGuest) {
                      Helpers.showGuestForbiddenAlert();
                      return;
                    }

                    _openModuleInWebview(_PlatVirtualModule.gimnasio);
                  },
                ),
                Category2Item(
                  text: 'Puntos de recreación',
                  textFontWeight: FontWeight.w700,
                  textColor: akWhiteColor,
                  bgColor: akPrimaryColor,
                  boxShadowColor: Colors.white,
                  iconBuilder: (focus) => CIconRecreacionv2(size: 80,
                    height: 50,),
                  onTap: () {
                    Get.toNamed(AppRoutes.PUNTOS_RECREACION);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAmbulanciaTap() async {
    if (_ambulanciaLoading.value) return;
    _ambulanciaLoading.value = true;

    await tryCatch(code: () async {
      await Helpers.sleep(1000);
      final _authXTmp = Get.find<AuthController>();
      final telefono = _authXTmp.personaStored!.telefono;
      final _ambulanciaProvider = AmbulanciaProvider();

      final disponible = await Helpers.checkServicioDisponible('AMBULANCIAAPP');
      if (!disponible) {
        return;
      }

      final resp =
          await _ambulanciaProvider.solicitarAmbulancia(numTelefono: telefono);
      if (resp.codigoRespuesta == '01') {
        AppSnackbar().info(
          message:
              'Solicitud exitosa!\nDentro de un momento te llamaremos. Por favor, espera...',
          duration: Duration(seconds: 6),
        );
      } else {
        throw BusinessException('No se pudo solicitar la ambulancia');
      }
    });
    _ambulanciaLoading.value = false;
  }

  Future<void> _openModuleInWebview(_PlatVirtualModule module) async {
    final _authXTmp = Get.find<AuthController>();

    final tipoDoc = _authXTmp.personaStored!.tipoDocIdentidad;
    final docIdentidad = _authXTmp.personaStored!.numDocIdentidad;

    // 01 - DNI
    // 08 -  CARNET DE EXTRANJERIA
    // 09 - PASAPORTE
    if (!['01', '08', '09'].contains(tipoDoc)) {
      AppSnackbar().info(
          message: 'Este módulo no está disponible para tu tipo de documento');
      return;
    }

    String url = Config().urlCanchaGimnasio;

    switch (module) {
      case _PlatVirtualModule.cancha:
        url +=
            '/ReservaCampoDeportivo?codtipodocumento=$tipoDoc&numdocumento=$docIdentidad';

        break;

      case _PlatVirtualModule.gimnasio:
        url +=
            '/MembresiaGimnasioMunicipal?codtipodocumento=$tipoDoc&numdocumento=$docIdentidad';
        break;
    }

    Get.to(
      WebviewWrapper(
        title: 'Reserva una cancha',
        url: url,
      ),
      transition: Transition.cupertino,
    );
  }
}

enum _PlatVirtualModule { cancha, gimnasio }

class _TitleSection extends StatelessWidget {
  final String title;
  final Color? textColor;

  const _TitleSection(
      this.title,this.textColor, {
        Key? key,

      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsize = akFontSize + 18.0;
    final fheight = fsize * 0.028;
    return AkText(
      title,
      style: TextStyle(
        fontFamily: 'Gisha',
        color: this.textColor,
        fontWeight: FontWeight.w300,
        fontSize: fsize - 1.0,
        height: fheight,
      ),
    );
  }
}

class _BigSection extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? bgColor;
  final List<Widget> children;
  final String? cover;
  const _BigSection({
    Key? key,
    required this.title,
    required this.textColor,
    this.bgColor = Colors.transparent,
    required this.children,
    this.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgRadius = 30.0;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: akContentPadding,
        vertical: akContentPadding,
      ),
      decoration: BoxDecoration(
        color: this.bgColor, // ANTES TENIA BORDER RADIUS TOP-LEFT y BOTT-LEFT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TitleSection(title,textColor),
          if (cover != null)
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  child: Image.asset(
                    cover!, // Ruta de la imagen
                    height: 145.0,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          padding: EdgeInsets.symmetric(
                            horizontal: akContentPadding - 10.0,
                            vertical: akContentPadding,
                          ),
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                          children: [
                            ...children,
                          ],
                        ),
                      ),
                    ),
                    /* Container(
                      width: 100.0,
                      height: 200.0,
                      color: Colors.red,
                    ) */
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsize = akFontSize + 18.0;
    final fheight = fsize * 0.028;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF586E28),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: akContentPadding * .35),
                Content(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ArrowBack(
                        onTap: () async {
                          Get.back();
                        },
                        color: akWhiteColor,
                      ),
                      LogoMuni(
                        whiteMode: true,
                        size: 200,
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: ArrowBack(
                          onTap: () async {},
                          color: akWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: akContentPadding * .8),

                /*
                V1
                Container(
                  padding: EdgeInsets.symmetric(horizontal: akContentPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5.0),
                          AkText(
                            'San Isidro',
                            style: TextStyle(
                              color: akWhiteColor,
                              fontWeight: FontWeight.w900,
                              fontSize: fsize,
                              fontStyle: FontStyle.italic,
                              height: fheight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: akWhiteColor,
                            size: fsize,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: AkText(
                              'CONTIGO',
                              style: TextStyle(
                                color: akAccentColor,
                                fontWeight: FontWeight.w900,
                                fontSize: fsize,
                                fontStyle: FontStyle.italic,
                                height: fheight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                */


              ],
            ),
          ),
        ),
      ],
    );
  }
}
