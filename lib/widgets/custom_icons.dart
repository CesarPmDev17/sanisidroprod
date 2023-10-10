part of 'widgets.dart';

class SpinLoadingIcon extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;

  const SpinLoadingIcon(
      {this.color = Colors.white, this.size = 30.0, this.strokeWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.size,
      width: this.size,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(this.color),
      ),
    );
  }
}

class CIconHandCard extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconHandCard({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/hand_card.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: size * 0.08,
          left: size * 0.08,
          child: SvgPicture.asset(
            'assets/icons/hand_card_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.33,
          ),
        ),
      ],
    );
  }
}

class CIconHandCardv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconHandCardv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/tributosv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconCreditCard extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconCreditCard({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/credit_card.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          bottom: size * 0.15,
          right: size * 0.14,
          child: SvgPicture.asset(
            'assets/icons/credit_card_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.54,
          ),
        ),
      ],
    );
  }
}

class CIconCreditCardv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconCreditCardv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/experienciavpsiv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconBus extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconBus({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/bus.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          bottom: size * 0.14,
          right: size * 0.22,
          child: SvgPicture.asset(
            'assets/icons/bus_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.54,
          ),
        ),
      ],
    );
  }
}

class CIconBusv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconBusv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/expresov2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconDialog extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconDialog({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/dialog.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: size * 0.25,
          left: size * 0.15,
          child: SvgPicture.asset(
            'assets/icons/dialog_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.7,
          ),
        ),
      ],
    );
  }
}

class CIconDialogv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconDialogv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/teescuchamosv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconBook extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconBook({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/icons/book.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          bottom: size * 0,
          right: -size * 0.1,
          child: SvgPicture.asset(
            'assets/icons/book_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.58,
          ),
        ),
      ],
    );
  }
}

class CIconPoll extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconPoll({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/icons/poll.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: -size * 0.32,
          left: size * 0.02,
          child: SvgPicture.asset(
            'assets/icons/poll_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.96,
          ),
        ),
      ],
    );
  }
}

class CIconEvent extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconEvent({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/event.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          bottom: size * 0.28,
          right: size * 0.18,
          child: SvgPicture.asset(
            'assets/icons/event_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.15,
          ),
        ),
      ],
    );
  }
}

class CIconVideo extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconVideo({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/video.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: size * 0.08,
          left: size * 0.08,
          child: SvgPicture.asset(
            'assets/icons/video_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.48,
          ),
        ),
      ],
    );
  }
}

class CIconVideov2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconVideov2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/msiinformav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconLandscape extends StatelessWidget {
  final double size;
  final Color? color1;
  final Color? color2;

  const CIconLandscape({this.size = 100.0, this.color1, this.color2});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/landscape.svg',
          color: color1 ?? akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: size * 0.28,
          right: size * 0.13,
          child: SvgPicture.asset(
            'assets/icons/landscape_alt.svg',
            color: color2 ?? akAccentColor,
            width: size * 0.53,
          ),
        ),
      ],
    );
  }
}

class CIconVPSIHappy extends StatelessWidget {
  final double size;

  const CIconVPSIHappy({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/icons/vpsi_happy.svg',
            width: size,
          ),
        ),
        Positioned(
          top: -size * 0.29,
          right: -size * 0.21,
          child: SvgPicture.asset(
            'assets/icons/vpsi_happy_alt_1.svg',
            color: akPrimaryColor,
            width: size * 0.95,
          ),
        ),
        Positioned(
          top: -size * 0.15,
          right: size * 0.02,
          child: SvgPicture.asset(
            'assets/icons/vpsi_happy_alt_2.svg',
            color: akAccentColor,
            width: size * 0.55,
          ),
        ),
      ],
    );
  }
}

class CIconPollChart extends StatelessWidget {
  final double size;

  const CIconPollChart({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/icons/bar_chart.svg',
          color: akPrimaryColor,
          width: size,
        ),
        Positioned(
          bottom: size * 0.14,
          right: size * 0.22,
          child: SvgPicture.asset(
            'assets/icons/bar_chart_alt.svg',
            color: akAccentColor,
            width: size * 0.80,
          ),
        ),
      ],
    );
  }
}

class CIconCircleCheck extends StatelessWidget {
  final double size;

  const CIconCircleCheck({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          'assets/icons/circle_check.svg',
          color: akPrimaryColor,
          width: size,
        ),
        Positioned(
          top: size * 0.1,
          right: -size * 0.06,
          child: SvgPicture.asset(
            'assets/icons/circle_check_alt.svg',
            color: akAccentColor,
            width: size * 0.85,
          ),
        ),
      ],
    );
  }
}

class CIconPagosTax extends StatelessWidget {
  final double size;

  const CIconPagosTax({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/icons/tax_girl.svg',
            // width: size,
          ),
        ),
        Positioned(
          bottom: size * 0.67,
          left: size * 0.29,
          child: Container(
            width: size * 0.21,
            height: size * 0.10,
            color: akAccentColor,
            child: Center(
              child: AkText(
                'Pagos',
                style: TextStyle(
                  color: akWhiteColor,
                  fontSize: size * 0.06,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class CIconSaniContigo extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconSaniContigo({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/cross.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconSaniContigov2 extends StatelessWidget {
  final double size;

  const CIconSaniContigov2({this.size = 200.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/saludv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,

        ),
      ],
    );
  }
}

class CIconSaniContigov2_2 extends StatelessWidget {
  final double size;

  const CIconSaniContigov2_2({this.size = 200.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/citasmedicasv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,

        ),
      ],
    );
  }
}


class CIconMovSostenible extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconMovSostenible({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/location_marker.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconMovSosteniblev2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconMovSosteniblev2({this.size = 100.0,this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/movilidadv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
        ),
      ],
    );
  }
}

class CIconCentroSaludv2 extends StatelessWidget { // esta no tiene v1
  final double size;
  final double height;

  const CIconCentroSaludv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/centrosaludv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconServMunicipales extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconServMunicipales({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/clip_document.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconServMunicipalesv2 extends StatelessWidget {
  final double size;

  const CIconServMunicipalesv2({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/serviciosv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
        ),
      ],
    );
  }
}

class CIconPlataformav2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconPlataformav2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/platvirtualv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconCiuResiliente extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconCiuResiliente({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/shield_warning.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconCiuResilientev2 extends StatelessWidget {
  final double size;

  const CIconCiuResilientev2({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/prevencionv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
        ),
      ],
    );
  }
}

class CIconSaniEcologico extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconSaniEcologico({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/leaf.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconSaniEcologicov2 extends StatelessWidget {
  final double size;

  const CIconSaniEcologicov2({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/ecologiav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
        ),
      ],
    );
  }
}

class CIconCultura extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconCultura({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/theater.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconCulturav2 extends StatelessWidget {
  final double size;

  const CIconCulturav2({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/culturav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
        ),
      ],
    );
  }
}

class CIconAmbulance extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconAmbulance({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/ambulance.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconAmbulancev2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconAmbulancev2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/ambulanciav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconGym extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconGym({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/gym.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconGymv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconGymv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/gymv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconRunShoes extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconRunShoes({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/run_shoes.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconSportsBalls extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconSportsBalls({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/sports_balls.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconStadium extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconStadium({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/stadium.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconStadiumv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconStadiumv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/canchav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconRecreacionv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconRecreacionv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/recreacionv2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconBicycle extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconBicycle({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/bicycle.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconBicyclev2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconBicyclev2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/cicloviav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconBicyclev2_1 extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconBicyclev2_1({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/cicloviav2.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconBikeParking extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconBikeParking({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/bike_parking.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconBikeParkingv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconBikeParkingv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/cicloparqueov2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

class CIconWrench extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconWrench({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/wrench.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconWrenchv2 extends StatelessWidget {
  final double size;
  final double height;

  const CIconWrenchv2({this.size = 100.0, this.height = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/img/biciasistenciav2.png', // Ruta de la imagen en los recursos de tu aplicación
          width: size,
          height: height,
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}



class CIconPhoneSOS extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconPhoneSOS({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/phone_sos.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconTrash extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconTrash({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/trash.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconSyncMarkers extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconSyncMarkers({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/sync_markers.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconPlant extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconPlant({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/plant.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}

class CIconAmbientKpi extends StatelessWidget {
  final double size;
  final Color? color;

  const CIconAmbientKpi({this.size = 100.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/icons/ambient_kpi.svg',
          color: color ?? akPrimaryColor,
          width: size,
        ),
      ],
    );
  }
}
