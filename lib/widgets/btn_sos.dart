part of 'widgets.dart';

class BtnSOS extends StatelessWidget {
  final String heroTag;
  final double size;
  final VoidCallback? onTap;
  final String text;
  final bool alertStyle;
  final bool animatedText;

  const BtnSOS({
    required this.heroTag,
    required this.size,
    this.onTap,
    this.text = 'SOS',
    this.alertStyle = false,
    this.animatedText = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget mainCircle = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Helpers.lighten(akSOSColor, 0.2),
            akSOSColor,
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          color: alertStyle ? Helpers.lighten(akSOSColor, 0.07) : null,
          gradient: alertStyle
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Helpers.lighten(akSOSColor),
                    akSOSColor,
                  ],
                ),
        ),
        child: Center(
          child: Flash(
            animate: animatedText,
            infinite: true,
            delay: Duration(milliseconds: 200),
            duration: Duration(seconds: 2),
            child: AkText(
              text,
              style: TextStyle(
                color: akWhiteColor.withOpacity(.65),
                fontSize: this.size * 0.2,
              ),
            ),
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        this.onTap?.call();
      },
      child: Hero(
        tag: heroTag,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(size * 0.05),
            decoration: !alertStyle
                ? BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(500),
                    gradient: RadialGradient(colors: [
                      Color(0xFFE6E6E6),
                      Color(0xFFE6E6E6),
                      Color(0xFFE6E6E6),
                      Color(0xFFD6D6D6),
                    ]),
                    boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFFFFFF),
                          offset: Offset(0, -5),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Color(0xFF0F0F0F).withOpacity(.18),
                          offset: Offset(0, 8),
                          blurRadius: 10,
                        )
                      ])
                : null,
            child: mainCircle,
          ),
        ),
      ),
    );
  }
}

class BtnSOS2 extends StatelessWidget {
  final String heroTag;
  final double size;
  final VoidCallback? onTap;
  final String text;
  final bool alertStyle;
  final bool animatedText;

  const BtnSOS2({
    required this.heroTag,
    required this.size,
    this.onTap,
    this.text = 'SOS',
    this.alertStyle = false,
    this.animatedText = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget mainCircle = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Helpers.lighten(akSOSColor, 0.2),
            akSOSColor,
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          color: alertStyle ? Helpers.lighten(akSOSColor, 0.07) : null,
          gradient: alertStyle
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Helpers.lighten(akSOSColor),
                    akSOSColor,
                  ],
                ),
        ),
        child: Center(
          child: Flash(
            animate: animatedText,
            infinite: true,
            delay: Duration(milliseconds: 200),
            duration: Duration(seconds: 2),
            child: AkText(
              text,
              style: TextStyle(
                color: akWhiteColor.withOpacity(.65),
                fontSize: this.size * 0.2,
              ),
            ),
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        this.onTap?.call();
      },
      child: Hero(
        tag: heroTag,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(size * 0.05),
            decoration: !alertStyle
                ? BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(500),
                    gradient: RadialGradient(colors: [
                      Color(0xFFE6E6E6),
                      Color(0xFFE6E6E6),
                      Color(0xFFE6E6E6),
                      Color(0xFFD6D6D6),
                    ]),
                    boxShadow: [
                        BoxShadow(
                          color: Color(0xFFFFFFFF),
                          offset: Offset(0, -5),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Color(0xFF0F0F0F).withOpacity(.18),
                          offset: Offset(0, 8),
                          blurRadius: 10,
                        )
                      ])
                : null,
            child: mainCircle,
          ),
        ),
      ),
    );
  }
}
