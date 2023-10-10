import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';

class CTItem extends StatelessWidget {
  final String name;
  final String img;
  final VoidCallback? onTap;

  const CTItem({
    Key? key,
    required this.name,
    required this.img,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bRadius = 12.0;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 0.0,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(bRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B8D8D).withOpacity(.55),
            offset: Offset(0, 7),
            blurRadius: 14,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(bRadius)),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: img,
                fit: BoxFit.cover,
                imageErrorBuilder: (_, __, ___) {
                  return SizedBox();
                },
                placeholderErrorBuilder: (_, __, ___) {
                  return SizedBox();
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                color: akPrimaryColor.withOpacity(.35),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      onTap?.call();
                    },
                    splashColor: akPrimaryColor.withOpacity(.45),
                    highlightColor: akPrimaryColor.withOpacity(.40),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: akWhiteColor,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(.85),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
