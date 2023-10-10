part of 'widgets.dart';

class Content extends StatelessWidget {
  final bool fluid;

  /// Creates a container with akContentPadding in horizontal Axis.
  Content({
    Key? key,
    this.child,
    this.fluid = false,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (fluid) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: akContentPadding),
        child: child,
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: akContentPadding),
      child: child,
    );
  }
}
