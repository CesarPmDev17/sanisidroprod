part of 'widgets.dart';

class MyPositionMarker extends StatelessWidget {
  final double size;
  final Color? color;
  const MyPositionMarker({Key? key, this.size = 28.0, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerColor = color ?? akPrimaryColor;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: size * 0.01,
          child: CircleMarker(
            color: markerColor,
            size: size * 0.34,
          ),
        ),
        Column(
          children: [
            Container(
              height: size * 0.85,
              width: size,
              decoration: BoxDecoration(
                color: akTitleColor,
                borderRadius: BorderRadius.circular(size * 0.1),
              ),
              child: Center(
                child: AkText(
                  'Yo',
                  style: TextStyle(
                    color: akWhiteColor,
                    fontSize: size * 0.55,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -size * 0.1),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(math.pi),
                child: Container(
                  width: size * 0.4,
                  child: AspectRatio(
                    aspectRatio: 10 / 8,
                    child: CustomPaint(
                      painter: _DrawTriangleShape(
                        colorTriangle: akTitleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size * 0.35),
          ],
        ),
      ],
    );
  }
}

class NearMarker extends StatelessWidget {
  final double size;
  final int number;
  final Color? color;
  final bool hideNumber;
  const NearMarker(
      {Key? key,
      this.size = 28.0,
      required this.number,
      this.color,
      this.hideNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerColor = color ?? akPrimaryColor;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: size * 0.01,
          child: CircleMarker(
            color: markerColor,
            size: size * 0.34,
          ),
        ),
        Column(
          children: [
            Container(
              height: size * 0.85,
              width: size,
              decoration: BoxDecoration(
                color: akTitleColor,
                borderRadius: BorderRadius.circular(size * 0.1),
              ),
              child: Center(
                child: hideNumber
                    ? Icon(
                        Icons.flag_outlined,
                        color: akWhiteColor,
                        size: akFontSize + 1.0,
                      )
                    : AkText(
                        '$number',
                        style: TextStyle(
                          color: akWhiteColor,
                          fontSize: size * 0.55,
                        ),
                      ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -size * 0.1),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(math.pi),
                child: Container(
                  width: size * 0.4,
                  child: AspectRatio(
                    aspectRatio: 10 / 8,
                    child: CustomPaint(
                      painter: _DrawTriangleShape(
                        colorTriangle: akTitleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size * 0.35),
          ],
        ),
      ],
    );
  }
}

class CircleMarker extends StatelessWidget {
  final Color? color;
  final double size;
  CircleMarker({
    Key? key,
    this.color,
    this.size = 9.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerColor = color ?? akPrimaryColor;

    return Container(
      padding: EdgeInsets.all(size * 0.5),
      child: Container(
        padding: EdgeInsets.all(size * 0.26),
        decoration: BoxDecoration(
            color: akWhiteColor,
            borderRadius: BorderRadius.circular(size * 2),
            boxShadow: [
              BoxShadow(
                color: markerColor.withOpacity(.25),
                offset: Offset(0, 2),
                spreadRadius: 2,
                blurRadius: 4,
              )
            ]),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: markerColor,
            borderRadius: BorderRadius.circular(size * 2),
          ),
        ),
      ),
    );
  }
}

class _DrawTriangleShape extends CustomPainter {
  final Color colorTriangle;

  _DrawTriangleShape({required this.colorTriangle});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    var paint = Paint();
    paint.color = colorTriangle;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, height);
    path.lineTo(width / 2, 0);
    path.lineTo(width, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BusMarker extends StatelessWidget {
  final Color? color;
  final double size;
  BusMarker({
    Key? key,
    this.color,
    this.size = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerColor = color ?? akPrimaryColor;

    return Container(
      padding: EdgeInsets.all(size * 0.2),
      child: Container(
        padding: EdgeInsets.all(size * 0.15),
        decoration: BoxDecoration(
            color: akWhiteColor,
            borderRadius: BorderRadius.circular(size * 2),
            boxShadow: [
              BoxShadow(
                color: markerColor.withOpacity(.25),
                offset: Offset(0, 2),
                spreadRadius: 2,
                blurRadius: 4,
              )
            ]),
        child: SvgPicture.asset(
          'assets/icons/bus_marker.svg',
          width: size,
          color: markerColor,
        ),
      ),
    );
  }
}
