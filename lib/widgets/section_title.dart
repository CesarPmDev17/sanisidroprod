part of 'widgets.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: AkText(
                title,
                style: TextStyle(
                  color: akTitleColor,
                  fontSize: akFontSize + 8.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
