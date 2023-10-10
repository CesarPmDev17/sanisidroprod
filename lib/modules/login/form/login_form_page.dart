import 'package:app_san_isidro/data/models/tipo_doc_identidad.dart';
import 'package:app_san_isidro/modules/login/form/login_form_controller.dart';
import 'package:app_san_isidro/modules/login/form/widgets/body_user_selectable.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginFormPage extends StatelessWidget {
  final _conX = Get.put(LoginFormController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _conX.handleBack,
      child: Scaffold(
        body: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: _buildContent(constraints),
                  physics: BouncingScrollPhysics(),
                );
              },
            ),
            _buildLoading(),
            Obx(() => _conX.isUserTypeVisisble.value
                ? BodyUserSelectable(
                    onLoginAsUser: _conX.loginAsUser,
                    onLoginAsGuest: _conX.loginAsGuest,
                  )
                : SizedBox())
          ],
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
            SizedBox(height: 10.0),
            AkText(
              'Registro',
              style: TextStyle(
                fontFamily: 'Gisha',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                height: 1.45,
                color: akPrimaryColor,
              ),
            ),
            SizedBox(height: 7.0),
            AkText('Completa el formulario',
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
          _buildLabel('Tipo de documento'),
          _buildInput(
            controller: _conX.tipoDocCtlr,
            hint: 'Selecciona el tipo',
            icon: Icons.arrow_downward,
            onlyRead: true,
            enabledClean: false,
            onTap: () async {
              final result = await _showOptions(_conX.tiposDocIdentidad);
              if (result is TipoDocIdentidad) {
                _conX.onSelectTipoDocIdentidad(result);
              }
            },
          ),
          _buildLabel('Número de documento'),
          GetBuilder<LoginFormController>(
            id: 'gbInputDocIdentidad',
            builder: (_) => _buildInput(
              controller: _conX.docIdentidadCtlr,
              hint: 'Ejemplo: 10101010',
              enabledClean: false,
              maxLength: _conX.maxLengthDocIdentidad,
              keyboardType: _conX.isNumericDocIdentidad
                  ? TextInputType.number
                  : TextInputType.text,
            ),
          ),
          _buildLabel('Nombre'),
          _buildInput(
            onChanged: (val) => _conX.nombres = val.trim(),
            onFieldCleaned: () => _conX.nombres = '',
            maxLength: 50,
            hint: 'Ejemplo: Ricardo',
          ),
          _buildLabel('Apellido paterno'),
          _buildInput(
            onChanged: (val) => _conX.apePaterno = val.trim(),
            onFieldCleaned: () => _conX.apePaterno = '',
            maxLength: 50,
            hint: 'Ejemplo: Pérez',
          ),
          _buildLabel('Apellido materno'),
          _buildInput(
            onChanged: (val) => _conX.apeMaterno = val.trim(),
            onFieldCleaned: () => _conX.apeMaterno = '',
            maxLength: 50,
            hint: 'Ejemplo: Luna',
          ),
          _buildLabel('Email'),
          _buildInput(
            onChanged: (val) => _conX.email = val.trim(),
            onFieldCleaned: () => _conX.email = '',
            maxLength: 50,
            hint: 'Ejemplo: ciudadano@gmail.com',
            textCapitalization: TextCapitalization.none,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: _conX.onCheckTermsTap,
                child: Container(
                  padding: EdgeInsets.all(akContentPadding * 0.5),
                  child: Obx(
                    () => CustomCheckbox(
                      isSelected: _conX.agreeTerms.value,
                      enabled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: GestureDetector(
                  onTap: _conX.onTermsLabelTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 7.0,
                    ),
                    child: AkText(
                      'Ver términos y condiciones',
                      style: TextStyle(
                        fontFamily: 'Gisha',
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        color: akPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<dynamic> _showOptions(List<dynamic> items) async {
    List<Widget> options = [];
    for (var item in items) {
      String _text = '';
      if (item is TipoDocIdentidad) {
        _text = item.descripcion;
      }

      options.add(Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () => Get.back(result: item),
          highlightColor: Colors.transparent,
          splashColor: akAccentColor,
          child: ListTile(
            title: AkText(Helpers.capitalizeFirstLetter(_text)),
          ),
        ),
      ));
    }
    final ScrollController controller = ScrollController();

    final resp = await Get.dialog(
        AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Container(
            width: 1000.0,
            constraints: BoxConstraints(minHeight: 10.0, maxHeight: 300.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: akScaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(akRadiusGeneral)),
            child: Theme(
              data: Theme.of(Get.context!).copyWith(
                highlightColor: akPrimaryColor,
              ),
              child: Scrollbar(
                radius: Radius.circular(30.0),
                thickness: 5.0,
                isAlwaysShown: true,
                controller: controller,
                child: ListView.builder(
                  // separatorBuilder: (c, i) => Divider(color: Colors.grey),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (c, idx) {
                    return options[idx];
                  },
                ),
              ),
            ),
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.35));

    return resp;
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
      width: 200, // Ancho deseado para el botón
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
    TextCapitalization textCapitalization = TextCapitalization.words,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: AkInput(
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        // size: AkInputSize.small,
        textCapitalization: textCapitalization,
        type: AkInputType.legend,
        /*  filledColor: Color(0xFFE7EAF3),
        filledFocusedColor: Color(0xFFE7EAF3),
        enabledBorderColor: Color(0xFFDADDE3), */
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

  Widget _buildLoading() {
    return Obx(() {
      if (_conX.loadingFormData.value) {
        Get.focusScope?.unfocus();
        return Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(color: Colors.white.withOpacity(.35)),
          child: Center(
            child: SpinLoadingIcon(
              color: akPrimaryColor,
            ),
          ),
        );
      }
      return SizedBox();
    });
  }
}
