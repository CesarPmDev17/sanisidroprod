import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:flutter/material.dart';

class SaludTitleScaffold extends StatelessWidget {
  final String title;
  final String subTitle;

  const SaludTitleScaffold({
    Key? key,
    this.title = '',
    this.subTitle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10.0),
        AkText(
          title,
          style: TextStyle(
            color: akPrimaryColor,
            fontSize: akFontSize + 5.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.0),
        AkText(
          subTitle,
          style: TextStyle(
            color: akPrimaryColor,
            fontSize: akFontSize,
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}
