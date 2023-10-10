import 'package:app_san_isidro/data/models/museo.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/cached_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MuseoVrItem extends StatelessWidget {
  final Museo museo;
  final void Function()? onTap;

  MuseoVrItem({required this.museo, this.onTap});

  @override
  Widget build(BuildContext context) {
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
                  child: CachedImg(imageUrl: museo.foto),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AkText(
                      museo.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: akTitleColor,
                        fontWeight: FontWeight.w400,
                        fontSize: akFontSize + 4.0,
                      ),
                    ),
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
