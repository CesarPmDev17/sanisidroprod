import 'package:app_san_isidro/modules/salud/lista/widgets/cita_avatar.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';

class SItemList extends StatelessWidget {
  final String title;
  final String subTitle;

  final VoidCallback? onTap;

  const SItemList({Key? key, this.title = '', this.subTitle = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemPadding = akContentPadding * 0.76;

    return Container(
      margin: EdgeInsets.only(bottom: akContentPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: akWhiteColor,
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
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                onTap?.call();
              },
              child: Container(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: itemPadding,
                    left: itemPadding,
                    bottom: itemPadding,
                    right: itemPadding * 0.30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CitaAvatar(),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AkText(
                                        title,
                                        style: TextStyle(
                                          color: akTitleColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: akFontSize + 1.0,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      AkText(
                                        subTitle,
                                        style: TextStyle(
                                          color: akTextColor,
                                          fontSize: akFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: akTextColor,
                            size: akFontSize + 2.0,
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
