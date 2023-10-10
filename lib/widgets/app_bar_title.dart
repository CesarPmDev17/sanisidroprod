part of 'widgets.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: 15.0,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4.0,
              decoration: BoxDecoration(
                  color: akPrimaryColor,
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: AkText(
                title,
                style: TextStyle(
                  color: akPrimaryColor,
                  fontSize: akFontSize + 10.0,
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
