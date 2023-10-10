import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DropHeader extends StatelessWidget {
  final VoidCallback? onTap;

  final String title;

  const DropHeader({
    Key? key,
    this.onTap,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorBg = Colors.white;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorBg,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFCBCBCB),
            width: 1,
          ),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          highlightColor: Helpers.darken(colorBg, 0.05),
          splashColor: Helpers.darken(colorBg),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.0),
            child: Content(
              child: Row(
                children: [
                  Expanded(
                    child: AkText(
                      title,
                      style: TextStyle(
                        color: akTitleColor,
                        fontSize: akFontSize + 2.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: akTitleColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
