import 'package:app_san_isidro/modules/videos/components/result_video_item.dart';
import 'package:app_san_isidro/modules/videos/detalle/videos_detalle_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosDetallePage extends StatelessWidget {
  final _conX = Get.put(VideosDetalleController());

  @override
  Widget build(BuildContext context) {
    if (_conX.playerCtlr == null) {
      return Scaffold(
        body: Center(
          child: AkText('Error'),
        ),
      );
    }

    final fechaPublicacion = (formatDate(
            _conX.videoData.snippet.publishedAt, [dd, ' de ', MM, ', ', yyyy],
            locale: SpanishDateLocale()))
        .toLowerCase();

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        actionsPadding: EdgeInsets.all(0),
        controller: _conX.playerCtlr!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: akPrimaryColor,
        progressColors: ProgressBarColors(
          backgroundColor: Colors.white.withOpacity(0.25),
          bufferedColor: Colors.white.withOpacity(0.50),
          playedColor: akAccentColor,
          handleColor: akAccentColor,
        ),
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: akScaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  Row(
                    children: [ArrowBack(onTap: () => Get.back())],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            player,
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 25.0),
                  Content(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AkText(
                          _conX.videoData.snippet.title,
                          style: TextStyle(
                            color: akTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: akFontSize + 6.0,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              color: akTitleColor.withOpacity(.30),
                              width: akFontSize - 2.0,
                            ),
                            SizedBox(width: 6.0),
                            Flexible(
                              child: AkText(
                                fechaPublicacion,
                                style: TextStyle(
                                    fontSize: akFontSize - 2.0,
                                    color: akTitleColor.withOpacity(.30)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 22.0),
                        Obx(() => AkText(
                              _conX.videoData.snippet.description,
                              maxLines: !_conX.showMore.value ? 8 : 500,
                              overflow: TextOverflow.ellipsis,
                            )),
                        SizedBox(height: 12.0),
                        Obx(() => _ReadMore(
                              onTap: _conX.toggleShowMoreStatus,
                              hideMode: _conX.showMore.value,
                            )),
                        SizedBox(height: 30.0),
                        AkText(
                          'Te puede interesar',
                          style: TextStyle(
                            color: akTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: akFontSize + 4.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _OtherVideos(_conX),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtherVideos extends StatelessWidget {
  final VideosDetalleController _conX;
  const _OtherVideos(this._conX, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> videoList = [];

    _conX.otherVideos.forEach((v) {
      videoList.add(ResultVideoItem(
        video: v,
        onTap: () async {
          await Get.delete<VideosDetalleController>();
          Get.offNamed(
            AppRoutes.VIDEOS_DETALLE,
            arguments: VideosDetalleArguments(
              videoData: v,
            ),
            preventDuplicates: false,
          );
        },
      ));
    });

    return Column(
      children: videoList,
    );
  }
}

class _ReadMore extends StatelessWidget {
  final void Function()? onTap;
  final bool hideMode;

  const _ReadMore({Key? key, this.onTap, required this.hideMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.0),
      // splashColor: Helpers.darken(akAccentColor, 0.2),
      // highlightColor: Helpers.darken(akAccentColor),
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 7.0,
        ),
        decoration: BoxDecoration(
          color: akAccentColor.withOpacity(.16),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: AkText(
          hideMode ? 'Mostrar menos' : 'Mostrar más',
          style: TextStyle(
            color: akAccentColor,
          ),
        ),
      ),
    );
  }
}
