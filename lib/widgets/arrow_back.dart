part of 'widgets.dart';

class ArrowBack extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;

  ArrowBack({this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-12.0, 0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              onTap?.call();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child:  Image.asset(
                'assets/img/next_icon.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
