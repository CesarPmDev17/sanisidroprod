part of 'ak_ui.dart';

// NOTA:
// Para visualizar todos los cambios debe hacer un Hot Restart
// de lo contrario, algunos colores, medidas y estilos
// NO se actualizarán correctamente.

double akRadiusDrawerContainer = 22;
double akRadiusSnackbar = akRadiusGeneral;
double akMapPaddingBase = 12.0;

Color akSOSColor = Color(0xFFC5273C);

void customizeAkStyle() {
  akPrimaryColor = Color(0xFF445118); // New color
  // akPrimaryColor = Color(0xFF3e521f);
  akAccentColor = Color(0xFF91a227);

  akSecondaryColor = akPrimaryColor.withOpacity(.8);

  akSuccessColor = Color(0xFF61BF09);
  akErrorColor = Color(0xFFF94844);
  akInfoColor = Color(0xFF36B4E7);
  akWarningColor = Color(0xFFFEBC33);

  akDefaultFontFamily = 'Lato';

  akFontSize = 15.0;

  akRadiusGeneral = 8.0;
  if (Get.width >= 360.0) {
    akContentPadding = 20.0;
  } else {
    akContentPadding = 12.0;
  }

  akScaffoldBackgroundColor = Color(0xFFEAEAEA);

  akIptFilledColor = Helpers.darken(akScaffoldBackgroundColor, 0.04);
  akIptFilledFocusedColor = Helpers.darken(akScaffoldBackgroundColor, 0.05);

  akIptOutlinedBorderColor = Helpers.darken(akScaffoldBackgroundColor, 0.1);

  akTitleColor = Color(0xFF0c2043);
  akTextColor = akTitleColor.withOpacity(.60);

  // Buttons
  akBtnBorderRadius = 30.0;

  akAppbarBackgroundColor = akAccentColor;
  akAppbarTextColor = akTextColor;
  akAppbarElevation = 0.0;
}

class Fonts {
  static const rubik = 'Rubik';
  static const lato = 'Lato';
}
