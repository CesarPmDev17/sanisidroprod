import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuestBanner extends StatelessWidget {
  final VoidCallback onBannerTap;
  final VoidCallback onCloseTap;

  const GuestBanner(
      {Key? key, required this.onBannerTap, required this.onCloseTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vPadding = akContentPadding * 0.6;
    final hPadding = akContentPadding * 0.8;

    final bannerColor = Color(0xFFF78621);

    return FadeInUp(
      delay: Duration(seconds: 1),
      child: Stack(
        children: [
          Container(
            color: bannerColor,
            margin: EdgeInsets.only(top: 22.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Helpers.lighten(bannerColor, 0.1),
                highlightColor: Helpers.lighten(bannerColor, 0.05),
                onTap: this.onBannerTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: hPadding,
                    vertical: vPadding,
                  ),
                  child: SafeArea(
                    left: false,
                    right: false,
                    top: false,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/guest_icon.svg',
                          width: 42.0,
                        ),
                        SizedBox(width: hPadding * 0.7),
                        Expanded(
                          child: AkText(
                            'Estás en modo invitado. Regístrate y accede a todos los módulos →',
                            style: TextStyle(
                              color: akWhiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: akFontSize + 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: InkWell(
              onTap: this.onCloseTap,
              child: Container(
                padding: EdgeInsets.all(6.5),
                decoration: BoxDecoration(
                  color: Helpers.darken(bannerColor, 0.035),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: akWhiteColor.withOpacity(.5),
                  size: akFontSize + 5.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
