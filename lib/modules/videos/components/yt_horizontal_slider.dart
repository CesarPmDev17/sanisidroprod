import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/modules/videos/detalle/videos_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YtHorizontalSlider extends StatelessWidget {
  final List<Item> videos;
  final bool loading;
  final bool hasError;
  final void Function()? onRetryTap;

  const YtHorizontalSlider({
    Key? key,
    required this.videos,
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
              _YtVideoItem(loading: true),
              _YtVideoItem(loading: true),
              _YtVideoItem(loading: true),
              _YtVideoItem(loading: true),
            ],
          ),
        ),
      );
    }

    List<Widget> videoCards = [];

    this.videos.forEach((v) {
      videoCards.add(_YtVideoItem(
        video: v,
        onPlayTap: (Item videoParam) {
          Get.toNamed(AppRoutes.VIDEOS_DETALLE,
              arguments: VideosDetalleArguments(
                videoData: videoParam,
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
              ...videoCards,
            ],
          ),
        ),
      ),
    );
  }
}

class _YtVideoItem extends StatelessWidget {
  final bool loading;
  final Item? video;
  final void Function(Item video)? onPlayTap;

  const _YtVideoItem(
      {Key? key, this.loading = false, this.video, this.onPlayTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radiusCard = BorderRadius.circular(8.0);

    final playSize = 25.0;

    String tituloVideo = '';

    if (video != null) {
      tituloVideo = video!.snippet.title + '\n\n';
    }

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 18.0,
            bottom: 20.0,
          ),
          decoration: BoxDecoration(
            borderRadius: radiusCard,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF8B8D8D).withOpacity(.10),
                offset: Offset(0, 4),
                spreadRadius: 4,
                blurRadius: 8,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: radiusCard,
            child: Container(
              color: Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 300.0,
                ),
                child: Container(
                  width: Get.width * 0.75,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 8,
                        child: Stack(
                          children: [
                            Container(
                              child: video != null
                                  ? ImageFade(
                                      imageUrl:
                                          video!.snippet.thumbnails.tMedium.url,
                                    )
                                  : SizedBox(),
                            ),
                            Positioned.fill(
                              child: Container(
                                color: akPrimaryColor.withOpacity(.25),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 15.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: loading
                                  ? _TextPlacerHolder()
                                  : AkText(
                                      tituloVideo,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: akTitleColor,
                                      ),
                                    ),
                            ),
                            Container(
                              height: 10.0,
                              width: playSize * 1.5,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60.0,
          right: 30.0,
          child: Container(
            decoration: BoxDecoration(
              color: loading
                  ? Helpers.darken(akScaffoldBackgroundColor, 0.1)
                  : akPrimaryColor,
              border: Border.all(color: akWhiteColor, width: 1.5),
              borderRadius: BorderRadius.circular(playSize * 3),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  if (video != null) {
                    onPlayTap?.call(video!);
                  }
                },
                borderRadius: BorderRadius.circular(playSize * 3),
                child: Container(
                  padding: EdgeInsets.all(playSize * 0.20),
                  child: Icon(
                    Icons.play_arrow,
                    color: akWhiteColor,
                    size: playSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
}
