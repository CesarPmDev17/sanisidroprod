part of 'widgets.dart';

class AlertNoContribuyente extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;

  const AlertNoContribuyente({Key? key, this.text = '', this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(6),
      color: const Color(0xFFCFCFCF),
      dashPattern: const <double>[4, 4],
      strokeWidth: 1.1,
      child: Container(
        decoration: BoxDecoration(
          color: Helpers.darken(akScaffoldBackgroundColor, 0.02),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: akContentPadding,
              vertical: akContentPadding * 0.5,
            ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/users.svg',
              color: akTextColor,
              width: Get.width * 0.17,
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: AkText(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: akFontSize + 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
