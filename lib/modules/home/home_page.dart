import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/modules/home/home_controller.dart';
import 'package:app_san_isidro/modules/home/widgets/guest_banner.dart';
import 'package:app_san_isidro/modules/home/widgets/home_header.dart';
import 'package:app_san_isidro/modules/home/widgets/menu_drawer.dart';
import 'package:app_san_isidro/modules/museo/components/museo_horizontal_slider.dart';
import 'package:app_san_isidro/modules/videos/components/yt_horizontal_slider.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatelessWidget {
  final _conX = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final drawerWidth = Get.width - 150.0;

    return ZoomDrawer(
      slideWidth: drawerWidth,
      duration: Duration(milliseconds: 200),
      openCurve: Curves.easeInOut,
      closeCurve: Curves.easeInOut,
      menuScreen: MenuDrawer(
        width: drawerWidth + 50.0,
        homeX: _conX,
      ),
      mainScreen: HomeContent(_conX),
    );
  }
}

class HomeContent extends StatelessWidget {
  final HomeController _conX;

  HomeContent(this._conX);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool canPop = Navigator.of(context).canPop();
        if (canPop) {
          return true;
        } else {
          final exitAppConfirm = await Helpers.confirmCloseAppDialog();
          return exitAppConfirm;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  color: const Color(0xFF586E28),
                  child: SafeArea(
                    child: Column(
                      children: [
                        HomeHeader(
                          welcomeName: _conX.shortFullName,
                          onMenuTap: () {
                            var zoomDrawer = ZoomDrawer.of(context)!;
                            zoomDrawer.open();
                            _conX.setStatusMenuVisible(true);
                          },
                          onSOSButtonTap: () {
                            if (_conX.authX.isGuest) {
                              Helpers.showGuestForbiddenAlert();
                              return;
                            }

                            Get.toNamed(AppRoutes.HOME_ALERTING);
                          },
                        ),
                        _Category2List(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFDEDEDE),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(0.0),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _TitleSection(
                                'MUCHO MÁS',
                                onMoreTap: () =>
                                    Get.toNamed(AppRoutes.MUSEO_LISTA),
                                bottomPadding: 5.0,
                              ),
                              _LugaresCategorySelector(),
                              SizedBox(height: 20.0),
                              MuseoHorizontalSlider(
                                museos: _conX.museosShort,
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              VisibilityDetector(
                                key: Key('vdTSVideos'),
                                onVisibilityChanged: (visibilityInfo) {
                                  _conX.ontitleVideoDisplayed();
                                },
                                child: _TitleSection(
                                  'ENTÉRATE',
                                  onMoreTap: () =>
                                      Get.toNamed(AppRoutes.VIDEOS_LISTA),
                                ),
                              ),
                              GetBuilder<HomeController>(
                                id: _conX.gbVideos,
                                builder: (_) => YtHorizontalSlider(
                                  videos: _conX.videos,
                                  loading: _conX.fetchingVideos,
                                  hasError: _conX.fetchVideosError,
                                  onRetryTap: _conX.onRetryVideosTap,
                                ),
                              ),
                              _TitleSection('MÁS CONECTADOS', showMore: false),
                              _SocialNetwork(),
                              SizedBox(height: 80.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (!Config().isProduction)
              Positioned(
                top: 50,
                right: 0,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(6.0),
                        ),
                      ),
                      child: AkText(
                        'Development',
                        style: TextStyle(
                          color: akWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_conX.authX.isGuest)
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Obx(
                      () => _conX.isGuestBannerVisible.value
                      ? GuestBanner(
                    onBannerTap: _conX.onGuestBannerTap,
                    onCloseTap: _conX.hideGuestBanner,
                  )
                      : SizedBox(),
                ),
              ),
            Positioned.fill(
              child: Obx(() => _conX.isMenuVisible.value
                  ? GestureDetector(
                onTap: () {
                  var zoomDrawer = ZoomDrawer.of(context)!;
                  zoomDrawer.close();
                  _conX.setStatusMenuVisible(false);
                },
                child: Container(
                  color: Colors.transparent,
                ),
              )
                  : SizedBox()),
            ),
          ],
        ),
      ),
    );
  }
}

class _LugaresCategorySelector extends StatelessWidget {
  const _LugaresCategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];

    items.add(SlideCategoryItem(
      text: 'Museos virtuales',
      isSelected: true,
      onTap: () {},
    ));
    /* items.add(SlideCategoryItem(
      text: 'Museos virtuales',
      isSelected: false,
      onTap: () {},
    )); */

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(width: akContentPadding * 0.25),
              ...items,
              SizedBox(
                width: akContentPadding,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  final double size;
  final void Function()? onPressed;

  MenuIcon({required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Widget _hs = SizedBox(
      width: size,
    );
    final Widget _vs = SizedBox(
      height: size,
    );
    final _dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: akTitleColor,
        borderRadius: BorderRadius.circular(size * 2),
      ),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        padding: EdgeInsets.all(akContentPadding),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dot,
                _hs,
                _dot,
              ],
            ),
            _vs,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dot,
                _hs,
                _dot,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Category2List extends StatelessWidget {
  final double iconSize = 29.0;

  const _Category2List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF586E28),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
        crossAxisSpacing: 40.0,
        mainAxisSpacing: 20.0,
        children: [
          Category2Item(
            text: 'SALUD',
            iconBuilder: (focus) => CIconSaniContigov2(
              size: iconSize + 15.0,

            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_SANI_CONTIGO);
            },
          ),
          Category2Item(
            text: 'MOVILIDAD',
            iconBuilder: (focus) => CIconMovSosteniblev2(
              size: iconSize + 15.0,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_MOV_SOSTENIBLE);
            },
          ),
          Category2Item(
            text: 'SERVICIOS',
            iconBuilder: (focus) => CIconServMunicipalesv2(
              size: iconSize + 15.0,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_SERV_MUNICIPALES);
            },
          ),
          Category2Item(
            text: 'PREVENCIÓN',
            iconBuilder: (focus) => CIconCiuResilientev2(
              size: iconSize + 15.0,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_CIUD_RESILIENTE);
            },
          ),
          Category2Item(
            text: 'ECOLOGÍA',
            iconBuilder: (focus) => CIconSaniEcologicov2(
              size: iconSize + 15.0,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_CIUDAD_ECOLOGICA);
            },
          ),
          Category2Item(
            text: 'CULTURA VIVA',
            iconBuilder: (focus) => CIconCulturav2(
              size: iconSize + 15.0,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.CATEG_CULTURA);
            },
          ),
        ],
      ),
    );
  }
}

class Category2Item extends StatefulWidget {
  final Widget Function(bool) iconBuilder;
  final String text;
  final Color? textColor;
  final Color? bgColor;
  final int? maxLines;
  final FontWeight? textFontWeight;
  final Color? boxShadowColor;

  final void Function()? onTap;

  Category2Item({
    required this.iconBuilder,
    this.text = '',
    this.onTap,
    this.textColor,
    this.bgColor,
    this.maxLines = 2,
    this.textFontWeight,
    this.boxShadowColor,
  });

  @override
  State<Category2Item> createState() => _Category2ItemState();
}

class _Category2ItemState extends State<Category2Item> {
  final double borderRadius = 7.0;
  bool _focus = false;

  Future<void> _onButtonTap() async {
    if (_focus) return;
    setState(() {
      _focus = true;
    });
    await Helpers.sleep(200);
    this.widget.onTap?.call();
    await Helpers.sleep(200);
    setState(() {
      _focus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor != null
              ? widget.bgColor
              : (_focus ? akAccentColor : Colors.white), //Color(0xFFEAEAEA)
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: widget.boxShadowColor?? Color(0xFF45521f),
              offset: Offset(4, 4),
              spreadRadius: 1.0,

            )
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: _onButtonTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.iconBuilder(_focus),
                SizedBox(height: 5.0),
                AkText(
                  widget.text,
                  textAlign: TextAlign.center,
                  maxLines: widget.maxLines,
                  style: TextStyle(
                    color: widget.textColor != null
                        ? widget.textColor
                        : (_focus ? akWhiteColor : Color(0xFF272528)),
                    fontSize: akFontSize - 2.0,
                    fontFamily: 'Gisha',
                    fontWeight: widget.textFontWeight ?? FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _TitleSection extends StatelessWidget {
  final String title;
  final bool showMore;
  final double? bottomPadding;
  final void Function()? onMoreTap;

  const _TitleSection(this.title,
      {Key? key, this.showMore = true, this.onMoreTap, this.bottomPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: akContentPadding * 1.15,
        bottom: bottomPadding ?? akContentPadding,
      ),
      child: Container(
        padding: EdgeInsets.only(left: akContentPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AkText(
                title,
                style: TextStyle(
                  fontFamily: 'Gisha',
                  color: const Color(0xFF586E28),
                  fontWeight: FontWeight.w700,
                  fontSize: akFontSize + 6.0,

                ),
              ),
            ),
            SizedBox(width: 8.0),
            showMore
                ? Padding(
                    padding: EdgeInsets.only(right: akContentPadding * 0.5),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6.0),
                      onTap: () {
                        onMoreTap?.call();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: akContentPadding * 0.65,
                          vertical: akContentPadding * 0.30,
                        ),
                        child:  Image.asset(
                          'assets/img/addv2.png',
                           width: 30,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _SocialNetwork extends StatelessWidget {
  const _SocialNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: akContentPadding),
            _SocialButton(
              iconName: 'facebook',
              url: 'https://www.facebook.com/MunicipalidaddeSanIsidro',
            ),
            _SocialButton(
              iconName: 'twitter',
              url: 'https://twitter.com/munisanisidro',
            ),
            _SocialButton(
              iconName: 'youtube',
              url: 'https://www.youtube.com/user/munisanisidro',
            ),
            _SocialButton(
              iconName: 'tiktok',
              url: 'https://www.tiktok.com/@munisanisidro',
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconName;
  final String url;
  const _SocialButton({Key? key, required this.iconName, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: GestureDetector(
        onTap: () {
          launchURL(url);
        },
        child: Container(
          child: SvgPicture.asset(
            'assets/icons/$iconName.svg',
            color: Color(0XFF808285),
            width: akFontSize * 2.0,
          ),
        ),
      ),
    );
  }

  Future<void> launchURL(String urlString) async {
    try {
      // ignore: deprecated_member_use
      if (!await launch(
        urlString,
        forceSafariVC: false,
        forceWebView: false,
      )) {
        throw 'Could not launch $urlString';
      }
    } catch (e) {
      AppSnackbar().error(message: 'No se pudo acceder al link:\n$urlString');
    }
  }
}
