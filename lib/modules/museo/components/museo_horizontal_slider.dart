import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/museo.dart';
import 'package:app_san_isidro/modules/museo/detalle/museo_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/cached_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MuseoHorizontalSlider extends StatelessWidget {
  final List<Museo> museos;
  final bool loading;
  final bool hasError;
  final void Function()? onRetryTap;

  const MuseoHorizontalSlider({
    Key? key,
    required this.museos,
    this.loading = false,
    this.hasError = false,
    this.onRetryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Container(
        padding: EdgeInsets.all(akContentPadding),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied_rounded,
                  color: akTitleColor,
                ),
                SizedBox(width: 5.0),
                Flexible(
                  child: AkText(
                    'Hubo un error',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: akTitleColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            AkButton(
              type: AkButtonType.outline,
              size: AkButtonSize.small,
              onPressed: () {
                onRetryTap?.call();
              },
              text: 'Recargar módulo',
            ),
            SizedBox(height: 30.0),
          ],
        ),
      );
    }

    if (loading) {
      return Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: akContentPadding),
              _HzMuseoItem(loading: true),
              _HzMuseoItem(loading: true),
              _HzMuseoItem(loading: true),
              _HzMuseoItem(loading: true),
            ],
          ),
        ),
      );
    }

    List<Widget> museoCards = [];

    this.museos.forEach((m) {
      museoCards.add(_HzMuseoItem(
        museo: m,
        onTap: (Museo museoParam) {
          Get.toNamed(AppRoutes.MUSEO_DETALLE,
              arguments: MuseoDetalleArguments(
                museoData: museoParam,
              ));
        },
      ));
    });

    return FadeIn(
      duration: Duration(milliseconds: 300),
      child: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: akContentPadding),
              ...museoCards,
            ],
          ),
        ),
      ),
    );
  }
}

class _HzMuseoItem extends StatelessWidget {
  final bool loading;
  final Museo? museo;
  final void Function(Museo museo)? onTap;

  const _HzMuseoItem({Key? key, this.loading = false, this.museo, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radiusCard = BorderRadius.circular(8.0);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 18.0,
            bottom: 30.0,
          ),
          decoration: BoxDecoration(
            borderRadius: radiusCard,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF8B8D8D).withOpacity(.55),
                offset: Offset(0, 7),
                blurRadius: 14,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: radiusCard,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  if (museo != null) {
                    onTap?.call(museo!);
                  }
                },
                child: Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 300.0,
                    ),
                    child: Container(
                      width: Get.width * 0.4,
                      child: AspectRatio(
                        aspectRatio: 8 / 13,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: museo != null
                                  ? CachedImg(imageUrl: museo!.foto)
                                  : SizedBox(),
                            ),
                            Positioned.fill(
                              child: Container(
                                color: akPrimaryColor.withOpacity(.35),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 40.0,
            ),
            child: AkText(
              museo?.titulo ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: akWhiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
/* 
class _TextPlacerHolder extends StatelessWidget {
  const _TextPlacerHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .80,
      child: Column(
        children: [
          SizedBox(height: 3.0),
          Row(
            children: [
              Expanded(
                child: Skeleton(
                  height: 10.0,
                  fluid: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Skeleton(height: 10.0, fluid: true),
              ),
              Expanded(flex: 4, child: SizedBox()),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
} */
