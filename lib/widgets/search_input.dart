part of 'widgets.dart';

class SearchInput extends StatelessWidget {
  final bool isBig;
  final void Function()? onSearchTap;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final void Function()? onFieldCleaned;

  SearchInput({
    Key? key,
    this.isBig = false,
    this.onSearchTap,
    this.controller,
    this.onChanged,
    this.onFieldCleaned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: akWhiteColor,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(.03),
            offset: Offset(0, 8),
            spreadRadius: 7,
            blurRadius: 15,
          )
        ],
      ),
      padding: isBig
          ? EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0)
          : EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
      child: Row(
        children: [
          Expanded(
            child: AkInput(
              controller: controller,
              onChanged: onChanged,
              onFieldCleaned: onFieldCleaned,
              size: isBig ? AkInputSize.big : AkInputSize.normal,
              enableMargin: false,
              type: AkInputType.noborder,
              enableClean: false,
              filledColor: Colors.transparent,
              filledFocusedColor: Colors.transparent,
              hintText: 'Escribe aquí...',
              labelColor: akTitleColor.withOpacity(.18),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: akPrimaryColor,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(9.0),
                splashColor: Helpers.darken(akPrimaryColor, 0.2),
                highlightColor: Helpers.darken(akPrimaryColor),
                onTap: () {},
                child: Container(
                  padding: isBig
                      ? EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0)
                      : EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: akWhiteColor,
                      width: isBig ? akFontSize + 10.0 : akFontSize + 5.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
