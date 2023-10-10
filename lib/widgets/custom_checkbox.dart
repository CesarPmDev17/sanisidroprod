part of 'widgets.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool enabled;

  CustomCheckbox({this.isSelected = false, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: akTitleColor.withOpacity(.09),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        Container(
          width: 9.0,
          height: 9.0,
          decoration: BoxDecoration(
            color: isSelected ? akPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ],
    );
  }
}
