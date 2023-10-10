part of '../../ak_ui.dart';

enum AkTextType {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  h7,
  h8,
  h9,
  subtitle1,
  subtitle,
  body1,
  body,
  button,
  comment,
  caption,
  overline,
  // Custom
  title
}

class AkText extends StatelessWidget {
  final String text;
  final AkTextType type;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AkText(this.text,
      {Key? key,
      this.type = AkTextType.body,
      this.style,
      this.textAlign = TextAlign.start,
      this.maxLines,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle dfStyle =
        TextStyle(color: akTextColor, fontFamily: akDefaultFontFamily);
    switch (this.type) {
      case AkTextType.h1:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 50.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h2:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 38.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h3:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 24.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h4:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 16.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h5:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 10.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h6:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 6.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h7:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 5.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h8:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 4.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.h9:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 3.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.subtitle1:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 2.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.subtitle:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
      case AkTextType.body1:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize + 1.0);
        break;
      case AkTextType.body:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize);
        break;
      case AkTextType.button:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize);
        break;
      case AkTextType.comment:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize - 1.0);
        break;
      case AkTextType.caption:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize - 2.0);
        break;
      case AkTextType.overline:
        dfStyle = dfStyle.copyWith(fontSize: akFontSize - 4.0);
        break;
      // Custom
      case AkTextType.title:
        dfStyle = dfStyle.copyWith(
          fontSize: akFontSize + 2.0,
          fontWeight: FontWeight.w500,
          color: akTitleColor,
        );
        break;
    }

    if (this.style != null) {
      dfStyle = dfStyle.merge(this.style);
    }

    return Text(
      this.text,
      textAlign: this.textAlign,
      style: dfStyle,
      maxLines: this.maxLines,
      overflow: this.overflow,
    );
  }
}
