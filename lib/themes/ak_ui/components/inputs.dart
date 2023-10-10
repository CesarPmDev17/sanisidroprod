part of '../../ak_ui.dart';

enum AkInputType { noborder, underline, legend, outline }
enum AkInputSize { mini, tiny, small, normal, big, huge, massive }

typedef AkInputOnChangedFunction<String> = void Function(String value);
typedef AkInputOnSavedFunction<String> = void Function(String value);
typedef AkInputValidator<String> = String? Function(String? value);

class AkInput extends StatefulWidget {
  final AkInputSize size;
  final AkInputType? type;

  final String? hintText;
  final String? labelText;

  final AkInputValidator<String>? validator;
  final AkInputOnChangedFunction<String>? onChanged;
  final AkInputOnSavedFunction<String?>? onSaved;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function()? onTap;

  final bool showCursor;
  final bool readOnly;
  final int maxLines;

  final bool enableMargin;

  final bool enableShadows;

  final FloatingLabelBehavior floatingLabelBehavior;

  final Color? filledColor;
  final Color? filledFocusedColor;

  final bool autofocus;

  final FocusNode? focusNode;

  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? labelColor;
  final Color? labelFocusedColor;
  final Color? textColor;

  final void Function()? onPrefixIconTap;
  final void Function()? onSuffixIconTap;

  final double? borderRadius;

  final int? maxLength;
  final TextAlign textAlign;

  final EdgeInsetsGeometry? contentPadding;

  final bool? forceOutline;

  final String? initialValue;

  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  final bool enableClean;
  final void Function()? onFieldCleaned;

  final double? factorPadding;
  final double? minPaddingSize;

  const AkInput({
    this.size = AkInputSize.normal,
    this.type,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onTap,
    this.showCursor = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.enableMargin = true,
    this.enableShadows = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.filledColor,
    this.filledFocusedColor,
    this.autofocus = false,
    this.focusNode,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.labelColor,
    this.labelFocusedColor,
    this.textColor,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.borderRadius,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.forceOutline,
    this.initialValue,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.enableClean = true,
    this.onFieldCleaned,
    this.factorPadding,
    this.minPaddingSize,
  });

  @override
  _AkInputState createState() => _AkInputState();
}

class _AkInputState extends State<AkInput> {
  TextEditingController? _controller;
  FocusNode? _node;
  bool _focused = false;

  bool _isEmpty = true;

  /*  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller; */

  @override
  void initState() {
    super.initState();

    if (this.widget.focusNode != null) {
      _node = this.widget.focusNode;
    } else {
      _node = FocusNode();
    }

    _node?.addListener(_handleFocusChange);

    /* if (widget.controller == null) {
      print('si');
      _controller = TextEditingController(text: null);
      _controller!.addListener(_handleControllerChanged);
    } else {
      print('no');
      widget.controller!.addListener(_handleControllerChanged);
    } */

    if (this.widget.initialValue == null) {
      if (this.widget.controller != null) {
        _controller = this.widget.controller;
      } else {
        _controller = TextEditingController();
      }
      _controller?.addListener(_handleControllerChanged);
    }
  }

  void _handleFocusChange() {
    if (_node?.hasFocus != _focused) {
      setState(() {
        // Version antes de Null Safety
        _focused = _node?.hasFocus ?? false;
      });
    }
  }

  void _handleControllerChanged() {
    if (_controller?.text.isEmpty != _isEmpty) {
      setState(() {
        // Version antes de Null Safety
        _isEmpty = _controller?.text.isEmpty ?? true;
      });
    }
  }

  @override
  void dispose() {
    if (this.widget.initialValue == null) {
      _controller?.removeListener(_handleControllerChanged);
      if (this.widget.controller == null) {
        _controller?.dispose();
      }
    }

    _node?.removeListener(_handleFocusChange);
    // The attachment will automatically be detached in dispose().
    if (this.widget.focusNode == null) {
      _node?.dispose();
    }

    super.dispose();
  }

  void _cleanTextController() {
    this._controller?.clear();
  }

  InputDecoration _asignCleanButton(InputDecoration input, Icon icon) {
    return input.copyWith(
      suffixIcon: AbsorbPointer(
        absorbing: false,
        child: IconButton(
          constraints: BoxConstraints(minWidth: 0, minHeight: 0),
          splashRadius: 20.0,
          padding: EdgeInsets.all(0.0),
          icon: icon,
          onPressed: () {
            if (_focused) {
              _cleanTextController();
              this.widget.onFieldCleaned?.call();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double iptTextFontSize = akFontSize;
    double minPadding = this.widget.minPaddingSize ?? iptTextFontSize;

    AkInputType localtype =
        (this.widget.type != null) ? this.widget.type! : akIptDefaulType;

    double _iptRadius = (this.widget.borderRadius != null)
        ? this.widget.borderRadius!
        : akIptBorderRadius;

    bool forceOutlineBorder =
        this.widget.forceOutline ?? akIptForceOutlineBorder;

    switch (this.widget.size) {
      case AkInputSize.mini:
        iptTextFontSize = iptTextFontSize * 0.4;
        break;
      case AkInputSize.tiny:
        iptTextFontSize = iptTextFontSize * 0.6;
        break;
      case AkInputSize.small:
        iptTextFontSize = iptTextFontSize * 0.8;
        break;
      case AkInputSize.normal:
        iptTextFontSize = iptTextFontSize * 1;
        break;
      case AkInputSize.big:
        iptTextFontSize = iptTextFontSize * 1.2;
        break;
      case AkInputSize.huge:
        iptTextFontSize = iptTextFontSize * 1.4;
        break;
      case AkInputSize.massive:
        iptTextFontSize = iptTextFontSize * 1.6;
        break;
    }
    double _factorPadding = this.widget.factorPadding ?? akIptFactorPadding;
    EdgeInsetsGeometry _iptPadding = EdgeInsets.symmetric(
        vertical: minPadding * _factorPadding,
        horizontal: minPadding * _factorPadding);

    double _enabledBorderWith = akIptBorderWidth;
    InputBorder _enabledBorder;

    Color _ebColor = (this.widget.enabledBorderColor != null)
        ? this.widget.enabledBorderColor!
        : akIptOutlinedBorderColor;

    switch (localtype) {
      case AkInputType.noborder:
        _enabledBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(_iptRadius),
            borderSide: BorderSide(
                color: Colors.transparent, width: _enabledBorderWith));

        break;
      case AkInputType.underline:
        _enabledBorderWith = _enabledBorderWith + 1.0;
        _enabledBorder = UnderlineInputBorder(
            borderRadius: BorderRadius.circular(_iptRadius),
            borderSide: BorderSide(color: _ebColor, width: _enabledBorderWith));
        if (this.widget.labelText != null) {
          _iptPadding = EdgeInsets.only(
            top: minPadding * (_factorPadding / 2),
            bottom: minPadding * _factorPadding,
            left: minPadding * _factorPadding,
            right: minPadding * _factorPadding,
          );
        }
        break;
      case AkInputType.legend:
        _enabledBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: const Color(0xFF202020), width: 1.2));
        break;
      case AkInputType.outline:
        _enabledBorder = UnderlineInputBorder(
            borderRadius: BorderRadius.circular(_iptRadius),
            borderSide: BorderSide(color: Colors.transparent, width: 0.0));
        double _top = minPadding * (_factorPadding / 1.75);
        if (this.widget.labelText != null) {
          if (_focused || !_isEmpty) {
            _top = minPadding * (_factorPadding / 2.3);
          }
          _iptPadding = EdgeInsets.only(
            top: _top,
            bottom: minPadding * (_factorPadding / 2),
            left: minPadding * _factorPadding,
            right: minPadding * _factorPadding,
          );
        }
        break;
    }

    Color _focusedBrdColor = (this.widget.focusedBorderColor != null)
        ? this.widget.focusedBorderColor!
        : akIptActiveBorderColor;
    InputBorder _focusedBorder = _enabledBorder.copyWith(
        borderSide:
            BorderSide(color: _focusedBrdColor, width: _enabledBorderWith));

    if (localtype == AkInputType.noborder) {
      _focusedBorder = _enabledBorder.copyWith(
          borderSide:
              BorderSide(color: Colors.transparent, width: _enabledBorderWith));
    } else if (localtype == AkInputType.outline) {
      _focusedBorder = _enabledBorder.copyWith(
          borderSide: BorderSide(color: Colors.transparent, width: 0.0));
    }

    InputBorder _errorBorder = _enabledBorder.copyWith(
        borderSide: BorderSide(
            color: akIptErrorBorderColor, width: _enabledBorderWith));

    Color _filledColor = (this.widget.filledColor != null)
        ? this.widget.filledColor!
        : akIptFilledColor;

    Color _filledFocusedColor = (this.widget.filledFocusedColor != null)
        ? this.widget.filledFocusedColor!
        : akIptFilledFocusedColor;

    double labelHintFontSize = iptTextFontSize;
    TextStyle _labelStyle =
        TextStyle(fontSize: labelHintFontSize, height: 1.25);
    if (_focused || !_isEmpty) {
      _labelStyle = _labelStyle.copyWith(fontSize: labelHintFontSize + 3.0);
    }

    Color _iptDecorationFilledColor = _filledColor;
    if (_focused) {
      _iptDecorationFilledColor = _filledFocusedColor;
    }

    InputDecoration _iptDecoration = InputDecoration(
      counterText: '',
      contentPadding: _iptPadding,
      hintText: this.widget.hintText,
      hintStyle: TextStyle(
        fontFamily: 'Gisha',
        fontWeight: FontWeight.w300,
        color: const Color(0xFFB848484),
      ),
      labelText: this.widget.labelText,
      labelStyle: _labelStyle,
      filled: true,
      fillColor: localtype != AkInputType.outline
          ? _iptDecorationFilledColor
          : Colors.transparent,
      isDense: true,
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      isCollapsed: false,
      errorStyle: TextStyle(
        fontSize: akFontSize * 0.8,
        color: akIptErrorTextColor,
        fontWeight: FontWeight.w500,
        height: 1.1,
      ),
      errorMaxLines: 10,
      floatingLabelBehavior: this.widget.floatingLabelBehavior,
    );

    Icon cleanIcon = Icon(
      Icons.cancel,
      color: _focused ? akIptLabelColor.withOpacity(.45) : Colors.transparent,
      size: iptTextFontSize + 4.0,
    );

    if (this.widget.prefixIcon != null && this.widget.suffixIcon != null) {
      _iptDecoration = _iptDecoration.copyWith(
        contentPadding: EdgeInsets.only(
          top: minPadding * _factorPadding,
          bottom: minPadding * _factorPadding,
          left: minPadding * _factorPadding,
          right: minPadding * _factorPadding * 0,
        ),
        prefixIcon: this.widget.prefixIcon,
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 0.0),
          child: this.widget.suffixIcon,
        ),
        prefixIconConstraints: BoxConstraints(
          minHeight: 32,
          minWidth: 40,
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 32,
          minWidth: 32,
        ),
      );
      Widget pfxicon = this.widget.prefixIcon!;
      if (pfxicon is Icon) {
        Icon newPfxIcon = Icon(
          pfxicon.icon,
          color: _focused ? akIptActiveBorderColor : akIptLabelColor,
          size: iptTextFontSize + 4.0,
        );
        _iptDecoration = _iptDecoration.copyWith(
            prefixIcon: IconButton(
          constraints: BoxConstraints(minWidth: 0, minHeight: 0),
          splashRadius: 20.0,
          padding: EdgeInsets.all(0.0),
          icon: newPfxIcon,
          onPressed: this.widget.onPrefixIconTap,
        ));
      }
      Widget sfxicon = this.widget.suffixIcon!;
      if (sfxicon is Icon) {
        Icon newSfxIcon = Icon(
          sfxicon.icon,
          color: _focused ? akIptActiveBorderColor : akIptLabelColor,
          size: iptTextFontSize + 4.0,
        );

        _iptDecoration = _iptDecoration.copyWith(
          contentPadding: EdgeInsets.only(
            top: minPadding * _factorPadding,
            bottom: minPadding * _factorPadding,
            right: 0,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 0.0),
            child: IconButton(
              constraints: BoxConstraints(minWidth: 0, minHeight: 0),
              splashRadius: 20.0,
              padding: EdgeInsets.all(0.0),
              icon: newSfxIcon,
              onPressed: this.widget.onSuffixIconTap,
            ),
          ),
        );
        if (this.widget.enableClean) {
          if (!_isEmpty) {
            _iptDecoration = _asignCleanButton(_iptDecoration, cleanIcon);
          }
        }
      }
    } else if (this.widget.prefixIcon != null) {
      _iptDecoration = _iptDecoration.copyWith(
        contentPadding: EdgeInsets.only(
          top: minPadding * _factorPadding,
          bottom: minPadding * _factorPadding,
          left: minPadding * _factorPadding,
          right: minPadding * _factorPadding * 0.3,
        ),
        prefixIcon: this.widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minHeight: 32,
          minWidth: 40,
        ),
      );
      Widget pfxicon = this.widget.prefixIcon!;
      if (pfxicon is Icon) {
        Icon newPfxIcon = Icon(
          pfxicon.icon,
          color: _focused ? akIptActiveBorderColor : akIptLabelColor,
          size: iptTextFontSize + 4.0,
        );
        _iptDecoration = _iptDecoration.copyWith(
            prefixIcon: IconButton(
          constraints: BoxConstraints(minWidth: 0, minHeight: 0),
          splashRadius: 20.0,
          padding: EdgeInsets.all(0.0),
          icon: newPfxIcon,
          onPressed: this.widget.onPrefixIconTap,
        ));
      }

      if (this.widget.enableClean) {
        if (!_isEmpty && _focused) {
          _iptDecoration = _iptDecoration.copyWith(
              contentPadding: EdgeInsets.only(
            top: minPadding * _factorPadding,
            bottom: minPadding * _factorPadding,
            right: 0,
          ));
          _iptDecoration = _asignCleanButton(_iptDecoration, cleanIcon);
        }
      }
    } else if (this.widget.suffixIcon != null) {
      EdgeInsetsGeometry sfxContent = EdgeInsets.only(
        top: minPadding * _factorPadding,
        bottom: minPadding * _factorPadding,
        left: minPadding * _factorPadding,
        right: minPadding * _factorPadding * 0.2,
      );
      _iptDecoration = _iptDecoration.copyWith(
        contentPadding: sfxContent,
        suffixIcon: this.widget.suffixIcon,
        suffixIconConstraints: BoxConstraints(
          minHeight: 32,
          minWidth: 40,
        ),
      );
      Widget sfxicon = this.widget.suffixIcon!;
      if (sfxicon is Icon) {
        Icon newSfxIcon = Icon(
          sfxicon.icon,
          color: _focused ? akIptActiveBorderColor : akIptLabelColor,
          size: iptTextFontSize + 4.0,
        );
        _iptDecoration = _iptDecoration.copyWith(
          suffixIcon: IconButton(
            constraints: BoxConstraints(minWidth: 0, minHeight: 0),
            splashRadius: 20.0,
            padding: EdgeInsets.all(0.0),
            icon: newSfxIcon,
            onPressed: this.widget.onSuffixIconTap,
          ),
        );
      }
      if (this.widget.enableClean) {
        if (!_isEmpty && _focused) {
          EdgeInsetsGeometry newSfxContent = EdgeInsets.only(
            top: minPadding * _factorPadding,
            bottom: minPadding * _factorPadding,
            left: minPadding * _factorPadding,
            right: 0,
          );
          _iptDecoration =
              _iptDecoration.copyWith(contentPadding: newSfxContent);
          _iptDecoration = _asignCleanButton(_iptDecoration, cleanIcon);
        }
      }
    } else {
      if (this.widget.enableClean) {
        _iptDecoration = _iptDecoration.copyWith(
          contentPadding: EdgeInsets.only(
            top: minPadding * _factorPadding,
            bottom: minPadding * _factorPadding,
            left: minPadding * _factorPadding,
            right: minPadding * _factorPadding * 0.2,
          ),
          suffixIcon: this.widget.suffixIcon,
          suffixIconConstraints: BoxConstraints(
            minHeight: 32,
            minWidth: 40,
          ),
        );
        if (!_isEmpty) {
          _iptDecoration = _asignCleanButton(_iptDecoration, cleanIcon);
        }
      }
    }

    if (this.widget.contentPadding != null) {
      _iptDecoration =
          _iptDecoration.copyWith(contentPadding: this.widget.contentPadding);
    }

    Color _txtColor = (this.widget.textColor != null)
        ? this.widget.textColor!
        : akIptTextColor;

    // print('tipo initial snull: ${this.widget.initialValue.runtimeType}');

    final _textFieldResult = TextFormField(
      initialValue: this.widget.initialValue,
      autofocus: this.widget.autofocus,
      obscureText: this.widget.obscureText,
      keyboardType: this.widget.keyboardType,
      controller: _controller,
      onTap: this.widget.onTap,
      onChanged: this.widget.onChanged,
      onSaved: this.widget.onSaved,
      showCursor: this.widget.showCursor,
      readOnly: this.widget.readOnly,
      maxLines: this.widget.maxLines,
      focusNode: _node,
      validator: this.widget.validator,
      cursorHeight: iptTextFontSize * 1.15,
      style: TextStyle(color: _txtColor, fontSize: iptTextFontSize),
      decoration: _iptDecoration,
      maxLength: this.widget.maxLength,
      textAlign: this.widget.textAlign,
      inputFormatters: this.widget.inputFormatters,
      textCapitalization: this.widget.textCapitalization,
      textInputAction: this.widget.textInputAction,
      onEditingComplete: this.widget.onEditingComplete,
      onFieldSubmitted: this.widget.onFieldSubmitted,
    );

    List<BoxShadow> inputShadows = [];
    if (this.widget.enableShadows) {
      inputShadows = [
        BoxShadow(
          color: Colors.black.withOpacity(0.075),
          spreadRadius: 1.5,
          blurRadius: 3,
          offset: Offset(0, 2), // changes position of shadow
        )
      ];
    }

    Color _lblColor = (this.widget.labelColor != null)
        ? this.widget.labelColor!
        : akIptLabelColor;

    Color _lblFcsdColor = (this.widget.labelFocusedColor != null)
        ? this.widget.labelFocusedColor!
        : akIptActiveLabelColor;

    BoxDecoration outDecoration = BoxDecoration(boxShadow: inputShadows);

    if (localtype == AkInputType.outline) {
      outDecoration = outDecoration.copyWith(
          color: _iptDecorationFilledColor,
          border: Border.all(
              color: forceOutlineBorder ? _ebColor : Colors.transparent,
              width: 2.0),
          borderRadius: BorderRadius.circular(_iptRadius));
      if (_focused) {
        outDecoration = outDecoration.copyWith(
            border: Border.all(color: akPrimaryColor, width: 2.0));
      }
    }

    return Theme(
        child: Container(
          margin: this.widget.enableMargin
              ? EdgeInsets.only(bottom: akDefaultGutterSize)
              : EdgeInsets.all(0.0),
          decoration: outDecoration,
          child: _textFieldResult,
        ),
        data: Theme.of(context).copyWith(
          primaryColor: _lblFcsdColor,
          // accentColor: Colors.indigo,
          hintColor: _lblColor, // akIptLabelColor,
        ));
  }
}
