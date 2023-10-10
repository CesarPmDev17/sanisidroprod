import 'package:app_san_isidro/modules/videos/components/result_video_item.dart';
import 'package:app_san_isidro/modules/videos/detalle/videos_detalle_controller.dart';
import 'package:app_san_isidro/modules/videos/lista/videos_lista_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideosListaPage extends StatelessWidget {
  final _conX = Get.put(VideosListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: akContentPadding * 0.5),
                  ArrowBack(onTap: () => Get.back()),
                  AppBarTitle('San Isidro al día'),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return GetBuilder<VideosListaController>(
      builder: (_) {
        if (_conX.fetchError) {
          return Center(
            child: _InfiniteListError(
              message: _conX.errorMessage,
              onRetry: _conX.retryFetch,
            ),
          );
        }

        if (_conX.fetchFinish) {
          if (_conX.listaVideos.isEmpty) {
            return Center(child: Text('No hay resultados'));
          }

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, int i) {
              return i >= _conX.listaVideos.length
                  ? _BottomLoader()
                  : Container(
                      margin: EdgeInsets.only(
                        bottom: 5.0,
                        top: i == 0 ? 0.0 : 0.0,
                      ),
                      child: ResultVideoItem(
                        video: _conX.listaVideos[i],
                        onTap: () {
                          Get.toNamed(AppRoutes.VIDEOS_DETALLE,
                              arguments: VideosDetalleArguments(
                                videoData: _conX.listaVideos[i],
                              ));
                        },
                      ),
                    );
            },
            itemCount: _conX.hasReachedMax
                ? _conX.listaVideos.length
                : _conX.listaVideos.length + 1,
            controller: _conX.scrollController,
          );
        }

        return Center(
          child: Transform.translate(
            offset: Offset(0, -60),
            child: LoadingOverlay(
              opacityNumber: 0,
            ),
          ), //  _BottomLoader(), // Loading inicial central
        );
      },
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: akPrimaryColor,
          ),
        ),
      ),
    );
  }
}

class _InfiniteListError extends StatelessWidget {
  final String title = 'Error!';
  final void Function()? onRetry;
  final String message;

  const _InfiniteListError({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final widthIcon = Get.size.width * 0.20;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(akContentPadding),
      // color: Colors.red,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/gear.svg',
              width: widthIcon,
              color: akTextColor.withOpacity(.35),
            ),
            SizedBox(height: 25.0),
            AkText(
              title,
              type: AkTextType.h8,
              style: TextStyle(color: akTextColor.withOpacity(.95)),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: AkText(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: akTextColor.withOpacity(.55)),
              ),
            ),
            SizedBox(height: 25.0),
            AkButton(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 11.0, horizontal: 20.0),
              onPressed: () {
                this.onRetry?.call();
              },
              type: AkButtonType.outline,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.replay_rounded, color: akTextColor),
                  SizedBox(width: 5.0),
                  AkText('Reintentar'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
