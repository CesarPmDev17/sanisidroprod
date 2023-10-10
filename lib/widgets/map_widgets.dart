part of 'widgets.dart';

class MapButton extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  const MapButton({
    Key? key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF8D8B8B).withOpacity(.4),
              offset: Offset(0, 4),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ]),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () {
            this.onTap?.call();
          },
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
