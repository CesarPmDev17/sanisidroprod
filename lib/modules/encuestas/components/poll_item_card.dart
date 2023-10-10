import 'dart:io';

import 'package:app_san_isidro/data/models/encuesta.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollItemCard extends StatelessWidget {
  final Directory directory;
  final Encuesta encuesta;
  final double innerPd = 16.0;
  final bool showButton;
  final void Function()? onTap;

  PollItemCard(
    this.encuesta,
    this.directory, {
    Key? key,
    this.showButton = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? imagenEncuesta;
    if (encuesta.archivoIcono != null &&
        Helpers.checkIfDataBase64IsImage(encuesta.archivoIcono!)) {
      imagenEncuesta =
          File(directory.path + '/encuesta_${encuesta.codEncuesta}.png');
      imagenEncuesta
        ..writeAsBytesSync(Helpers.getDecodedBytes(encuesta.archivoIcono!));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8D8B8B).withOpacity(.10),
            offset: Offset(0, 4),
            spreadRadius: 6,
            blurRadius: 12,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          decoration: BoxDecoration(
            color: akWhiteColor,
          ),
          child: Row(
            children: [
              imagenEncuesta != null
                  ? Container(
                      margin: EdgeInsets.only(left: innerPd * 0.75),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Helpers.darken(akScaffoldBackgroundColor)
                                .withOpacity(.25),
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: Offset(1, 2),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Container(
                          width: Get.width * 0.15,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child:
                                Image.file(imagenEncuesta, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: innerPd * 0.2),
                    Container(
                      padding: EdgeInsets.only(
                          top: innerPd, left: innerPd * 0.75, right: innerPd),
                      child: AkText(
                        encuesta.encuesta,
                        style: TextStyle(
                          fontSize: akFontSize + 0.0,
                          color: akTitleColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: innerPd * 1.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Container(
                              margin: EdgeInsets.only(left: innerPd * 0.75),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: akAccentColor.withOpacity(.26),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: AkText(
                                'Público',
                                style: TextStyle(
                                  fontSize: akFontSize - 6.0,
                                  color: akAccentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        !showButton
                            ? Container(height: 32.0)
                            : Container(
                                decoration: BoxDecoration(
                                  color: akPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      bottomLeft: Radius.circular(6.0)),
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    splashColor:
                                        Helpers.darken(akPrimaryColor, 0.2),
                                    highlightColor:
                                        Helpers.darken(akPrimaryColor),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.0),
                                        bottomLeft: Radius.circular(6.0)),
                                    onTap: () {
                                      this.onTap?.call();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 35.0,
                                        vertical: 8,
                                      ),
                                      child: AkText(
                                        'EMPEZAR',
                                        style: TextStyle(
                                          fontSize: akFontSize - 4.0,
                                          color: akWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
