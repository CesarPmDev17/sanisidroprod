part of '../../ak_ui.dart';

enum AkButtonType { solid, outline }

enum AkButtonSize { mini, tiny, small, normal, big, huge, massive }

enum AkButtonVariant {
  primary,
  secondary,
  accent,
  red,
  orange,
  yellow,
  olive,
  green,
  teal,
  blue,
  violet,
  purple,
  pink,
  brown,
  grey,
  black,
  white,
}

class AkButton extends StatefulWidget {
  const AkButton({
    required this.onPressed,
    this.text = '',
    this.textColor,
    this.textAlign = TextAlign.center,
    this.textStyle,
    this.child,
    this.type = AkButtonType.solid,
    this.size = AkButtonSize.normal,
    this.onHighlightChanged,
    this.elevation,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 4.0,
    this.disabledElevation = 0.0,
    this.variant = AkButtonVariant.primary,
    this.prefixIcon,
    this.suffixIcon,
    this.onlyIcon,
    this.enableMargin = true,
    this.contentPadding,
    this.verticalAlign = CrossAxisAlignment.center,
    this.horizontalAlign = MainAxisAlignment.center,
    this.fluid = false,
    this.backgroundColor,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.childMargin,
    this.disabled = false,
    this.disabledOpacity = .25,
  });

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  final String text;
  final Color? textColor;
  final TextAlign textAlign;
  final TextStyle? textStyle;

  final Widget? child;

  final AkButtonType type;
  final AkButtonSize size;

  /// Called by the underlying [InkWell] widget's InkWell.onHighlightChanged callback.
  final ValueChanged<bool>? onHighlightChanged;

  /// The elevation for the button's [Material] when the button is [enabled] but not pressed.
  final double? elevation;

  /// The elevation for the button's [Material] when the button is [enabled] and a pointer is hovering over it.
  final double hoverElevation;

  /// The elevation for the button's [Material] when the button is [enabled] and has the input focus.
  final double focusElevation;

  /// The elevation for the button's [Material] when the button is [enabled] and pressed.
  final double highlightElevation;

  /// The elevation for the button's [Material] when the button is not [enabled].
  final double disabledElevation;

  final AkButtonVariant variant;

  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? onlyIcon;

  final bool enableMargin;

  final CrossAxisAlignment verticalAlign;
  final MainAxisAlignment horizontalAlign;

  final bool fluid;

  final Color? backgroundColor;

  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;

  final EdgeInsetsGeometry? childMargin;

  /// Whether the button is enabled or disabled.
  // bool get enabled => onPressed != null;

  final bool disabled;
  final double disabledOpacity;

  @override
  _AkButtonState createState() => _AkButtonState();
}

class _AkButtonState extends State<AkButton> {
  final Set<MaterialState> _states = <MaterialState>{};

  // AnimationController _animationController;
  //  Animation<double> _animationTween;

  bool get _hovered => _states.contains(MaterialState.hovered);
  bool get _focused => _states.contains(MaterialState.focused);
  bool get _pressed => _states.contains(MaterialState.pressed);
  bool get _disabled => _states.contains(MaterialState.disabled);

  @override
  void initState() {
    super.initState();

    /* _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animationTween =
        Tween(begin: 0.25, end: 0.45).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    }); */
    // _animationController.forward();
  }

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleHighlightChanged(bool value) {
    /*  if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    } */

    // _animationController.forward();
    if (_pressed != value) {
      setState(() {
        _updateState(MaterialState.pressed, value);
        if (widget.onHighlightChanged != null) {
          widget.onHighlightChanged!(value);
        }
      });
    }
    // print('valuor de handle hihglith $value');
  }

  void _handleFocusedChanged(bool value) {
    /* if (_focused != value) {
      setState(() {
        _updateState(MaterialState.focused, value);
      });
    } */
    // print('valuor de handle focusd $value');
  }

  double get _effectiveElevation {
    // These conditionals are in order of precedence, so be careful about
    // reorganizing them.
    if (_disabled) {
      return widget.disabledElevation;
    }
    if (_pressed) {
      return widget.highlightElevation;
    }
    if (_hovered) {
      return widget.hoverElevation;
    }
    if (_focused) {
      return widget.focusElevation;
    }

    double defaultElevation = (this.widget.elevation != null)
        ? this.widget.elevation!
        : akBtnElevation;
    return defaultElevation;
  }

  Color effectiveShadow(Color color) {
    Color efs = color;
    /* if (_disabled) {
      return efs;
    }
    if (_pressed) {
      return efs.withOpacity(0.9);
    }
    if (_hovered) {
      return efs;
    }
    if (_focused) {
      return efs;
    } */

    // return efs.withOpacity(0.25);
    // return efs.withOpacity(_animationTween.value);
    return efs;
  }

  @override
  Widget build(BuildContext context) {
    ShapeBorder shapeBorderType;
    BorderRadiusGeometry finalRadiusGeometry;

    Color colorButton;
    Color colorText = Colors.white;
    double elevationButton = _effectiveElevation;
    Color highlightSplashColor = Colors.black;

    double defaultAppFontSize = akFontSize;
    double btnTextFontSize = defaultAppFontSize;

    Widget _child = SizedBox();

    TextStyle localTextStyle;

    List<BoxShadow> buttonShadows = [];

    switch (this.widget.size) {
      case AkButtonSize.mini:
        btnTextFontSize = btnTextFontSize * 0.4;
        break;
      case AkButtonSize.tiny:
        btnTextFontSize = btnTextFontSize * 0.6;
        break;
      case AkButtonSize.small:
        btnTextFontSize = btnTextFontSize * 0.8;
        break;
      case AkButtonSize.normal:
        btnTextFontSize = btnTextFontSize * 1;
        break;
      case AkButtonSize.big:
        btnTextFontSize = btnTextFontSize * 1.2;
        break;
      case AkButtonSize.huge:
        btnTextFontSize = btnTextFontSize * 1.4;
        break;
      case AkButtonSize.massive:
        btnTextFontSize = btnTextFontSize * 1.6;
        break;
    }
    double _factorPadding = akBtnFactorPadding;
    EdgeInsetsGeometry cntPadding = EdgeInsets.symmetric(
        vertical: btnTextFontSize * _factorPadding,
        horizontal: btnTextFontSize * _factorPadding);

    if (this.widget.contentPadding != null) {
      cntPadding = this.widget.contentPadding!;
    }

    // Colors
    switch (this.widget.variant) {
      case AkButtonVariant.primary:
        colorButton = akPrimaryColor;
        break;
      case AkButtonVariant.secondary:
        colorButton = akSecondaryColor;
        break;
      case AkButtonVariant.accent:
        colorButton = akAccentColor;
        break;
      case AkButtonVariant.red:
        colorButton = akRedColor;
        break;
      case AkButtonVariant.orange:
        colorButton = akOrangeColor;
        break;
      case AkButtonVariant.yellow:
        colorButton = akYellowColor;
        break;
      case AkButtonVariant.olive:
        colorButton = akOliveColor;
        break;
      case AkButtonVariant.green:
        colorButton = akGreenColor;
        break;
      case AkButtonVariant.teal:
        colorButton = akTealColor;
        break;
      case AkButtonVariant.blue:
        colorButton = akBlueColor;
        break;
      case AkButtonVariant.violet:
        colorButton = akVioletColor;
        break;
      case AkButtonVariant.purple:
        colorButton = akPurpleColor;
        break;
      case AkButtonVariant.pink:
        colorButton = akPinkColor;
        break;
      case AkButtonVariant.brown:
        colorButton = akBrownColor;
        break;
      case AkButtonVariant.grey:
        colorButton = akGreyColor;
        break;
      case AkButtonVariant.black:
        colorButton = akBlackColor;
        break;
      case AkButtonVariant.white:
        colorButton = akWhiteColor;
        colorText = Colors.black;
        break;
    }

    if (this.widget.backgroundColor != null) {
      colorButton = this.widget.backgroundColor!;
    }

    if (this.widget.borderRadiusGeometry != null) {
      finalRadiusGeometry = this.widget.borderRadiusGeometry!;
    } else {
      if (this.widget.borderRadius != null) {
        finalRadiusGeometry = BorderRadius.circular(this.widget.borderRadius!);
      } else {
        finalRadiusGeometry = akBtnBorderRadiusGeometry;
      }
    }

    shapeBorderType = RoundedRectangleBorder(
      borderRadius: finalRadiusGeometry,
      side: BorderSide(
        color: colorButton,
        width: 1,
      ),
    );

    if (this.widget.type == AkButtonType.outline) {
      colorText = colorButton;
      highlightSplashColor = colorButton;
      colorButton = Colors.transparent;
      elevationButton = 0.0;
    }

    if (this.widget.textColor != null) {
      colorText = this.widget.textColor!;
    }

    localTextStyle = TextStyle(
      fontSize: btnTextFontSize,
      color: colorText,
    );
    if (this.widget.textStyle != null) {
      localTextStyle = localTextStyle.merge(this.widget.textStyle);
    }

    Widget _btnTxt = Text('${this.widget.text}',
        textAlign: this.widget.textAlign, style: localTextStyle);

    _child = _btnTxt;

    Widget? pfxicon = this.widget.prefixIcon;
    Widget? customPfxIcon;
    Widget? sfxicon = this.widget.suffixIcon;
    Widget? customSfxIcon;
    Widget? oIcon = this.widget.onlyIcon;
    Widget aloneIcon;

    if (this.widget.child != null) {
      _child = this.widget.child!;
    } else if (oIcon != null) {
      if (oIcon is Icon) {
        aloneIcon = Icon(
          oIcon.icon,
          color: colorText,
          size: btnTextFontSize,
        );
      } else {
        aloneIcon = oIcon;
      }
      _child = aloneIcon;
    } else {
      if (pfxicon != null) {
        if (pfxicon is Icon) {
          customPfxIcon = Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Icon(
              pfxicon.icon,
              color: colorText,
              size: btnTextFontSize,
            ),
          );
        } else {
          customPfxIcon = pfxicon;
        }
      }
      if (sfxicon != null) {
        if (sfxicon is Icon) {
          customSfxIcon = Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Icon(
              sfxicon.icon,
              color: colorText,
              size: btnTextFontSize,
            ),
          );
        } else {
          customSfxIcon = sfxicon;
        }
      }

      if (pfxicon != null || sfxicon != null) {
        _child = Row(
            crossAxisAlignment: this.widget.verticalAlign,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: this.widget.horizontalAlign,
            children: [
              customPfxIcon != null ? customPfxIcon : SizedBox(),
              _child,
              customSfxIcon != null ? customSfxIcon : SizedBox(),
            ]);
      }
    }

    /* 
    ELIMINAR
    elevationButton = 0.0;
    if (this.widget.type != AkButtonType.outline) {
      buttonShadows = <BoxShadow>[
        BoxShadow(
          color: effectiveShadow(colorButton),
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ];
    } */

    final Widget button = Container(

      child: Material(
        elevation: elevationButton,
        color: colorButton,
        shape: shapeBorderType,
        type: MaterialType.button,
        child: InkWell(
          onHighlightChanged: _handleHighlightChanged,
          onFocusChange: _handleFocusedChanged,
          highlightColor: highlightSplashColor.withOpacity(0.15),
          splashColor: highlightSplashColor.withOpacity(0.1),
          customBorder: shapeBorderType,
          onTap: this.widget.onPressed,
          child: Container(
            padding: cntPadding,
            width: this.widget.fluid ? double.infinity : null,
            decoration: BoxDecoration(
              borderRadius: finalRadiusGeometry,
              boxShadow: buttonShadows,
            ),
            child: Padding(
              padding: this.widget.childMargin != null
                  ? this.widget.childMargin!
                  : EdgeInsets.all(0.0),
              child: _child,
            ),
          ),
        ),
      ),
    );

    return AbsorbPointer(
      absorbing: this.widget.disabled,
      child: Opacity(
        opacity: this.widget.disabled ? this.widget.disabledOpacity : 1,
        child: Semantics(
          child: Focus(
            onFocusChange: _handleFocusedChanged,
            child: Container(
              margin: this.widget.enableMargin
                  ? EdgeInsets.only(bottom: akDefaultGutterSize)
                  : EdgeInsets.all(0.0),
              child: button,
            ),
          ),
        ),
      ),
    );
  }
}
