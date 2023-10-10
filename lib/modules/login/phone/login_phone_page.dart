import 'package:app_san_isidro/modules/login/phone/login_phone_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPhonePage extends StatelessWidget {
  final _conX = Get.put(LoginPhoneController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: _buildContent(constraints),
              physics: BouncingScrollPhysics(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(akContentPadding),
          child: Column(
            children: [
              _buildTitle(),
              _buildForm(),
              Expanded(child: SizedBox()), // No quitar
              _buildMainButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              bottom: false,
              top: false,
              child: ArrowBack(
                onTap: () async {
                  if (await _conX.handleBack()) Get.back();
                },
              ),
            ),
            SizedBox(height: 10.0),
            AkText(
              'Un último paso',
              style: TextStyle(
                fontFamily: 'Gisha',
                fontWeight: FontWeight.w700,
                color: akPrimaryColor,
                fontSize: akFontSize + 8.0,
              ),
            ),
            SizedBox(height: 7.0),
            AkText(
                'Es posible que se envíe un código SMS de verificación.',
                style: TextStyle(
                  fontFamily: 'Gisha',
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFFB848484),
                ),
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Número de celular'),
          _buildInput(
            hint: '987 654 321',
            inputFormatters: [MaskTextInputFormatter(mask: "### ### ### ###")],
            maxLength: 15,
            onChanged: (val) => _conX.telefono = val.trim().replaceAll(' ', ''),
            onFieldCleaned: () => _conX.telefono = '',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton() {
    Widget spin = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinLoadingIcon(
          color: akWhiteColor,
          size: akFontSize + 3.0,
          strokeWidth: 3.0,
        )
      ],
    );


    return Obx(() => Container(
      width: 170, // Establece el ancho deseado
      child: AkButton(
        fluid: true,
        enableMargin: false,
        onPressed: _conX.onContinuarTap,
        text: 'Continuar',
        textStyle: TextStyle(
          fontFamily: 'Gisha',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        child: _conX.loadingSubmit.value ? spin : null,
      ),
    ));

  }

  Widget _buildLabel(String txt) {
    return AkText(
      txt,
      style: TextStyle(
        fontFamily: 'Gisha',
        fontWeight: FontWeight.w700,
        color: akPrimaryColor,
        fontSize: akFontSize + 1.0,
      ),
    );
  }

  Widget _buildInput({
    required String hint,
    TextEditingController? controller,
    IconData? icon,
    bool onlyRead = false,
    void Function()? onTap,
    bool enabledClean = true,
    int maxLength = 30,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
    void Function()? onFieldCleaned,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: AkInput(
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        type: AkInputType.legend,
        hintText: hint,
        inputFormatters: inputFormatters,
        labelColor: akTitleColor.withOpacity(.36),
        suffixIcon: icon != null ? Icon(icon) : null,
        readOnly: onlyRead,
        showCursor: !onlyRead,
        enableClean: enabledClean,
        onFieldCleaned: onFieldCleaned,
        onTap: () {
          onTap?.call();
        },
      ),
    );
  }
}
