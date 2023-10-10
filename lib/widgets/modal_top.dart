part of 'widgets.dart';

class ModalTop extends StatelessWidget {
  const ModalTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 6.0,
      decoration: BoxDecoration(
        color: akScaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
