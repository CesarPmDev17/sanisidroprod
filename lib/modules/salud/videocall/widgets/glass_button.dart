import 'dart:ui';

import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? btnColor;
  final double btnMinSize;
  const GlassButton({
    Key? key,
    required this.child,
    this.onTap,
    this.btnColor,
    this.btnMinSize = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.black.withOpacity(.50);
    if (btnColor != null) {
      buttonColor = btnColor!;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Helpers.darken(buttonColor, 0.1),
              onTap: () {
                onTap?.call();
              },
              child: Container(
                constraints: BoxConstraints(
                  minHeight: btnMinSize,
                  minWidth: btnMinSize,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
