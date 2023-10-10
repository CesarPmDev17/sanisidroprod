part of 'widgets.dart';

class LogoMuni extends StatelessWidget {
  final double size;
  final bool whiteMode;

  LogoMuni({this.size = 100, this.whiteMode = false});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      this.whiteMode
          ? 'assets/img/logo_muniv2_white2.png' // 'assets/img/logo_escudo_white.png'
          : 'assets/img/logo_muniv2_color.png',
      width: size,
    );
  }
}

class LogoEscudo extends StatelessWidget {
  final double size;
  final bool whiteMode;

  LogoEscudo({this.size = 100, this.whiteMode = false});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      this.whiteMode
          ? 'assets/img/logo_escudo_white.png'
          : 'assets/img/logo_escudo_color.png',
      width: size,
    );
  }
}
