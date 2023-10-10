part of 'widgets.dart';

class RoundedDiamonds extends StatelessWidget {
  final double size;

  RoundedDiamonds({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: this.size * 0.07),
            child: _Diamond(
              size: size,
              color: akAccentColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: this.size * 0.7),
            child: _Diamond(
              size: size,
              color: akPrimaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: this.size * 0.33,
              top: this.size * 0.5,
            ),
            child: _Diamond(
              size: size,
              color: Helpers.lighten(akScaffoldBackgroundColor, 0.03),
            ),
          )
        ],
      ),
    );
  }
}

class _Diamond extends StatelessWidget {
  final double size;
  final Color color;

  _Diamond({required this.size, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        // border: Border.all(color: color),
        borderRadius: BorderRadius.circular(9),
      ),
    );
  }
}

class RoundedDiamondsOutline extends StatelessWidget {
  final double size;

  RoundedDiamondsOutline({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Stack(
        children: [
          _DiamondOutline(
            size: size,
            color: akAccentColor,
          ),
          Padding(
            padding: EdgeInsets.only(top: this.size * 1.7),
            child: _DiamondOutline(
              size: size,
              color: akTitleColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: this.size * 0.45,
              top: this.size * 0.6,
            ),
            child: _DiamondOutline(
              size: size,
              color: akPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}

class _DiamondOutline extends StatelessWidget {
  final double size;
  final Color color;

  _DiamondOutline({required this.size, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2.0),
        borderRadius: BorderRadius.circular(9),
      ),
    );
  }
}
