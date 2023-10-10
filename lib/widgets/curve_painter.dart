part of 'widgets.dart';

class CurveCornerPainter extends CustomPainter {
  Color color;

  CurveCornerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(
      size.width * 0.92,
      size.height * 0.95,
      size.width * 0.35,
      size.height * 1,
    );

    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WaveCurvePainter extends CustomPainter {
  Color color;

  WaveCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final width = size.width;
    final height = size.height;

    var path = Path();
    path.moveTo(width, height);
    path.quadraticBezierTo(
      width * 0.95,
      height * 0.55,
      width * 0.75,
      height * 0.60,
    );
    path.quadraticBezierTo(
      width * 0.65,
      height * 0.65,
      width * 0.52,
      height * 0.45,
    );
    path.quadraticBezierTo(
      width * 0.22,
      -(height * 0.20),
      0,
      height * 0.4,
    );
    path.lineTo(0, height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TriangleCardPainter extends CustomPainter {
  Color color;

  TriangleCardPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final width = size.width;
    final height = size.height;

    var path = Path();
    path.lineTo(width, 0);
    path.lineTo(width, height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MiscCurvePainter extends CustomPainter {
  Color color;

  MiscCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final width = size.width;
    final height = size.height;

    var path = Path();
    path.moveTo(0, height);
    path.quadraticBezierTo(
      width * 0.5,
      -(height * 0.8),
      width,
      height,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BigHeaderCurvePainter extends CustomPainter {
  Color color;

  BigHeaderCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    final width = size.width;
    final height = size.height;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height * 0.89);
    path.quadraticBezierTo(
      width * 0.63,
      height * 1.05,
      0,
      height * 0.97,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BigHeaderColorCurvePainter extends CustomPainter {
  Color color;

  BigHeaderColorCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    var paint = Paint();
    // paint.color = this.color;
    paint.shader = RadialGradient(
      colors: [
        Helpers.lighten(this.color, 0.1),
        this.color,
      ],
    ).createShader(
      Rect.fromCircle(
        center: Offset(height * 0.22, height * 0.85),
        radius: height * 0.35,
      ),
    );
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width, height * 0.89);
    path.quadraticBezierTo(
      width * 0.97,
      height * 1,
      width * 0.75,
      height * 1,
    );
    path.quadraticBezierTo(
      width * 0.37,
      height * 0.99,
      width * 0,
      height * 1,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
