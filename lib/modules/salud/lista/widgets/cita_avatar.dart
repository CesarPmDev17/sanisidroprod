import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';

class CitaAvatar extends StatelessWidget {
  final double size;

  const CitaAvatar({Key? key, this.size = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Helpers.darken(akScaffoldBackgroundColor, 0.05),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: akScaffoldBackgroundColor,
          width: 6.0,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.health_and_safety_outlined,
          color: akTitleColor,
          size: size * 0.4,
        ),
      ),
    );
  }
}
