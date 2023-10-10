part of 'widgets.dart';

class AppSnackbar {
  AppSnackbar._internal();
  static AppSnackbar get _instance => AppSnackbar._internal();

  factory AppSnackbar() {
    return _instance;
  }

  bool allFilled = true;
  SnackPosition defaultPosition = SnackPosition.TOP;

  void basic({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnack(
      message: message,
      filledColor: akScaffoldBackgroundColor,
      filled: true,
      position: defaultPosition,
      textColor: akTextColor,
      duration: duration,
    );
  }

  void success({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnack(
      message: message,
      icon: Icons.check_rounded,
      filledColor: akScaffoldBackgroundColor,
      filled: true,
      position: defaultPosition,
      textColor: akSuccessColor,
      iconColor: akSuccessColor,
      duration: duration,
    );
  }

  void error({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnack(
      message: message,
      icon: Icons.warning_amber_rounded,
      filledColor: akScaffoldBackgroundColor,
      filled: true,
      position: defaultPosition,
      textColor: akErrorColor,
      iconColor: akErrorColor,
      duration: duration,
    );
  }

  void info({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnack(
      message: message,
      icon: Icons.info_outline_rounded,
      filledColor: akScaffoldBackgroundColor,
      filled: true,
      position: defaultPosition,
      textColor: akTextColor,
      iconColor: akInfoColor,
      duration: duration,
    );
  }

  void warning({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showSnack(
      message: message,
      icon: Icons.info_outline_rounded,
      filledColor: akScaffoldBackgroundColor,
      filled: true,
      position: defaultPosition,
      textColor: akTextColor,
      iconColor: akWarningColor,
      duration: duration,
    );
  }

  void _showSnack({
    String? title,
    String? message,
    IconData? icon,
    bool showIcon = true,
    SnackPosition position = SnackPosition.TOP,
    bool showClose = true,
    Color filledColor = Colors.grey,
    bool filled = true,
    Color textColor = Colors.black,
    Color? iconColor,
    Duration? duration,
  }) {
    TextStyle _dfStyle = TextStyle(color: textColor, fontSize: akFontSize);

    Color _dfIconColor = iconColor ?? textColor;

    Widget? _titleWidget;
    if (title != null)
      _titleWidget =
          AkText(title, style: _dfStyle.copyWith(fontWeight: FontWeight.w600));

    Widget? _messageWidget;
    if (message != null) _messageWidget = AkText(message, style: _dfStyle);

    Widget? _preffixIcon;
    if (icon != null && showIcon)
      _preffixIcon = ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          color: _dfIconColor.withOpacity(.15),
          padding: EdgeInsets.only(top: 6, right: 6, left: 6, bottom: 8),
          child: Icon(
            icon,
            color: _dfIconColor,
            size: akFontSize + 3,
          ),
        ),
      );

    double _bp = 3.0;
    EdgeInsetsGeometry snbPadding = EdgeInsets.all(_bp);

    if (showClose) {
      if (showIcon) {
        snbPadding =
            EdgeInsets.only(top: _bp, right: 0, bottom: _bp, left: _bp + 3.0);
        if (icon == null) {
          snbPadding =
              EdgeInsets.only(top: _bp, right: 0, bottom: _bp, left: _bp + 8.0);
        }
      } else {
        snbPadding =
            EdgeInsets.only(top: _bp, right: 0, bottom: _bp, left: _bp + 3.0);
      }
    } else {
      if (showIcon) {
        snbPadding = EdgeInsets.only(
            top: _bp, right: _bp + 3.0, bottom: _bp, left: _bp + 3.0);
      } else {
        snbPadding =
            EdgeInsets.symmetric(horizontal: _bp + 3.0, vertical: _bp + 3.0);
      }
    }

    Widget? _closeIcon;
    if (showClose)
      _closeIcon = ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              if (Get.isSnackbarOpen ?? false) {
                Get.back();
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.close,
                color: textColor.withOpacity(.35),
                size: akFontSize,
              ),
            ),
          ),
        ),
      );

    Widget _builderContent = Container(
      padding: snbPadding,
      child: Row(
        children: [
          showIcon ? _preffixIcon ?? SizedBox() : SizedBox(),
          showIcon && _preffixIcon != null ? SizedBox(width: 10.0) : SizedBox(),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleWidget ?? SizedBox(),
                  _messageWidget ?? SizedBox(),
                ],
              ),
            ),
          ),
          _closeIcon ?? SizedBox(),
        ],
      ),
    );

    if (Get.isSnackbarOpen ?? false) {
      Get.back(); // To close active Snackbar
    }

    Get.snackbar('', '',
        titleText: SizedBox(),
        messageText: _builderContent,
        padding: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 5),
        margin: EdgeInsets.all(akContentPadding),
        backgroundColor: filled ? filledColor : Colors.white,
        duration: duration,
        animationDuration: Duration(milliseconds: 300),
        snackPosition: position,
        dismissDirection: DismissDirection.horizontal,
        borderRadius: 8,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 6.0,
            spreadRadius: 4.0,
            offset: Offset(0, 3),
          )
        ]);
  }
}
