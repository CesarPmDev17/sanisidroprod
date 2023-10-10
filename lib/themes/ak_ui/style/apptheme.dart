part of '../../ak_ui.dart';

ThemeData akStyleAppTheme() {
  final theme = ThemeData.light();

  return ThemeData(
      scaffoldBackgroundColor: akScaffoldBackgroundColor,
      primaryColor: akPrimaryColor,
      colorScheme: theme.colorScheme.copyWith(
        onSecondary: akAccentColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: akPrimaryColor,
        selectionColor: akPrimaryColor,
        selectionHandleColor: akPrimaryColor,
      ),
      fontFamily: akDefaultFontFamily,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        color: akAppbarBackgroundColor,
        centerTitle: true,
        elevation: akAppbarElevation,
      ),
      primaryIconTheme: IconThemeData(color: akAppbarTextColor),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            color: akAppbarTextColor,
            fontWeight: akAppbarFontWeight,
            fontSize: akFontSize + 3.0), // Appbar
      ),
      textTheme: TextTheme(
          bodyText2: TextStyle(
              // height: 0.85,
              color: akTextColor,
              fontSize: akFontSize)));
}

ThemeData akStyleAppDarkTheme() {
  final theme = ThemeData.light();

  return ThemeData(
      scaffoldBackgroundColor: akScaffoldBackgroundColor,
      primaryColor: akPrimaryColor,
      colorScheme: theme.colorScheme.copyWith(
        onSecondary: akAccentColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: akPrimaryColor,
        selectionColor: akPrimaryColor,
        selectionHandleColor: akPrimaryColor,
      ),
      fontFamily: akDefaultFontFamily,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        color: akAppbarBackgroundColor,
        centerTitle: true,
        elevation: akAppbarElevation,
      ),
      primaryIconTheme: IconThemeData(color: akAppbarTextColor),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            color: akAppbarTextColor, fontSize: akFontSize + 3.0), // Appbar
      ),
      textTheme: TextTheme(
          bodyText2: TextStyle(
              // height: 0.85,
              color: akTextColor,
              fontSize: akFontSize)));
}
