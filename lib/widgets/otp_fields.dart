part of 'widgets.dart';

class OTPFields extends StatefulWidget {
  final bool hasError;
  final TextEditingController pin1;
  final TextEditingController pin2;
  final TextEditingController pin3;
  final TextEditingController pin4;
  final TextEditingController pin5;
  final TextEditingController pin6;

  OTPFields({
    Key? key,
    this.hasError = false,
    required this.pin1,
    required this.pin2,
    required this.pin3,
    required this.pin4,
    required this.pin5,
    required this.pin6,
  }) : super(key: key);

  @override
  _OTPFieldsState createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  FocusNode? pin1FN;
  FocusNode? pin2FN;
  FocusNode? pin3FN;
  FocusNode? pin4FN;
  FocusNode? pin5FN;
  FocusNode? pin6FN;

  @override
  void initState() {
    super.initState();
    pin1FN = FocusNode();
    pin2FN = FocusNode();
    pin3FN = FocusNode();
    pin4FN = FocusNode();
    pin5FN = FocusNode();
    pin6FN = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FN?.dispose();
    pin2FN?.dispose();
    pin3FN?.dispose();
    pin4FN?.dispose();
    pin5FN?.dispose();
    pin6FN?.dispose();
  }

  void nextField(String value, FocusNode? nextNode) {
    if (value.length == 1) {
      nextNode?.requestFocus();
    }
  }

  void previousField(RawKeyEvent event, FocusNode? previousNode) {
    if (event.runtimeType == RawKeyDownEvent &&
        (event.logicalKey.keyId == 4295426090)) {
      previousNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color _c = !this.widget.hasError ? akIptOutlinedBorderColor : akErrorColor;

    double space = 6.0;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              OPTInput(
                controller: widget.pin1,
                focusNode: pin1FN,
                onChanged: (v) => nextField(v, pin2FN),
                onKey: (e) {},
                borderColor: _c,
              ),
              SizedBox(width: space),
              OPTInput(
                controller: widget.pin2,
                focusNode: pin2FN,
                onChanged: (v) => nextField(v, pin3FN),
                onKey: (e) => previousField(e, pin1FN),
                borderColor: _c,
              ),
              SizedBox(width: space),
              OPTInput(
                controller: widget.pin3,
                focusNode: pin3FN,
                onChanged: (v) => nextField(v, pin4FN),
                onKey: (e) => previousField(e, pin2FN),
                borderColor: _c,
              ),
              SizedBox(width: space),
              OPTInput(
                controller: widget.pin4,
                focusNode: pin4FN,
                onChanged: (v) => nextField(v, pin5FN),
                onKey: (e) => previousField(e, pin3FN),
                borderColor: _c,
              ),
              SizedBox(width: space),
              OPTInput(
                controller: widget.pin5,
                focusNode: pin5FN,
                onChanged: (v) => nextField(v, pin6FN),
                onKey: (e) => previousField(e, pin4FN),
                borderColor: _c,
              ),
              SizedBox(width: space),
              OPTInput(
                controller: widget.pin6,
                focusNode: pin6FN,
                onChanged: (v) {
                  if (v.length == 1) {
                    FocusScope.of(context).unfocus();
                  }
                },
                onKey: (e) => previousField(e, pin5FN),
                borderColor: _c,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OPTInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function(RawKeyEvent) onKey;
  final Color borderColor;

  OPTInput({
    required this.controller,
    this.focusNode,
    required this.onChanged,
    required this.onKey,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: RawKeyboardListener(
          focusNode: new FocusNode(),
          child: AkInput(
            controller: controller,
            focusNode: focusNode,
            enableClean: false,
            enableMargin: false,
            enabledBorderColor: this.borderColor,
            type: AkInputType.legend,
            hintText: '0',
            labelColor: akTextColor.withOpacity(0.15),
            textAlign: TextAlign.center,
            contentPadding: EdgeInsets.symmetric(vertical: 18.0),
            // showCursor: false,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: onChanged,
            inputFormatters: [MaskTextInputFormatter(mask: "#")],
          ),
          onKey: onKey,
        ),
      ),
    );
  }
}
