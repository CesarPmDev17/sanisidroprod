part of 'widgets.dart';

class ModalConfirm extends StatelessWidget {
  final String text;
  const ModalConfirm(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          akRadiusGeneral * 2,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AkText(
            '¿Desea cancelar el proceso de pago?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: akFontSize + 2.0,
            ),
          ),
          SizedBox(height: 18.0),
          Row(
            children: [
              Expanded(
                child: AkButton(
                  size: AkButtonSize.small,
                  type: AkButtonType.outline,
                  text: 'SÍ',
                  onPressed: () => Get.back(result: true),
                  enableMargin: false,
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                child: AkButton(
                  size: AkButtonSize.small,
                  text: 'NO',
                  onPressed: () => Get.back(result: false),
                  enableMargin: false,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
    );
  }
}
