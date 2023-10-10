part of '../../ak_ui.dart';

class AkCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;

  final double? paddingSize;

  final Color backgroundColor;

  final Color? boxShadowColor;

  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;

  final bool disableShadows;

  final BoxBorder? border;

  const AkCard({
    required this.child,
    this.margin = const EdgeInsets.all(15.0),
    this.paddingSize,
    this.backgroundColor = Colors.white,
    this.boxShadowColor,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.disableShadows = false,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry cardRadiusGeometry;
    List<BoxShadow> localBoxShadows = [];
    Color localBoxShadowColor;

    localBoxShadowColor = (this.boxShadowColor != null)
        ? this.boxShadowColor!
        : akCardShadowColor;

    cardRadiusGeometry = (this.borderRadius != null)
        ? BorderRadius.all(Radius.circular(this.borderRadius!))
        : BorderRadius.all(Radius.circular(akCardBorderRadius));

    if (this.borderRadiusGeometry != null) {
      cardRadiusGeometry = this.borderRadiusGeometry!;
    } else {
      if (this.borderRadius != null) {
        cardRadiusGeometry = BorderRadius.circular(this.borderRadius!);
      } else {
        cardRadiusGeometry = akCardBorderRadiusGeometry;
      }
    }

    if (!this.disableShadows) {
      localBoxShadows = [
        BoxShadow(
            color: localBoxShadowColor.withOpacity(0.25),
            offset: Offset(0, 8),
            blurRadius: 8,
            spreadRadius: 10)
      ];
    }

    BoxDecoration _effectiveDecoration = BoxDecoration(
        color: this.backgroundColor,
        borderRadius: cardRadiusGeometry,
        boxShadow: localBoxShadows);

    if (this.border != null) {
      _effectiveDecoration = _effectiveDecoration.copyWith(border: this.border);
    }

    return Container(
      margin: this.margin,
      padding: EdgeInsets.all(this.paddingSize ?? akCardPaddingSize),
      decoration: _effectiveDecoration,
      child: this.child,
    );
  }
}
