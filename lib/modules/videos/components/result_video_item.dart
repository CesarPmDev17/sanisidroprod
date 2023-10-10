import 'package:app_san_isidro/data/models/youtube.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultVideoItem extends StatelessWidget {
  final Item video;
  final void Function()? onTap;

  ResultVideoItem({required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    final fechaPublicacion = (formatDate(
            video.snippet.publishedAt, [dd, ' de ', MM, ', ', yyyy],
            locale: SpanishDateLocale()))
        .toLowerCase();

    return Container(
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: akContentPadding,
            vertical: 8.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.29,
                height: Get.width * 0.18,
                decoration: BoxDecoration(
                  border: Border.all(color: akAccentColor, width: 1.0),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: ImageFade(
                    imageUrl: video.snippet.thumbnails.tMedium.url,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AkText(
                      video.snippet.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: akTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: AkText(
                            fechaPublicacion,
                            style: TextStyle(
                              color: akTitleColor.withOpacity(.30),
                              fontSize: akFontSize - 2.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SkelContainer(),
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
