part of 'widgets.dart';

class SlideCategoryItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  final double radius = 30.0;
  final bool placeHolder;

  SlideCategoryItem(
      {Key? key,
      this.isSelected = false,
      this.text = '',
      this.onTap,
      this.placeHolder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotSize = 5.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        placeHolder
            ? Container(
                margin: EdgeInsets.only(left: akContentPadding * 0.75),
                child: Opacity(
                  opacity: .61,
                  child: Column(
                    children: [
                      SizedBox(height: 12.0),
                      Skeleton(
                        width: Get.width * 0.25,
                        height: 12.0,
                      ),
                      SizedBox(height: 5.0),
                      Skeleton(
                        width: 7.0,
                        height: 7.0,
                      ),
                      SizedBox(height: 3.0),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(
                  right: 0.0,
                ),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(radius),
                    onTap: () {
                      onTap?.call();
                    },
                    child: Container(
                      width: placeHolder ? Get.width * 0.25 : null,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: akContentPadding * 0.75,
                        vertical: 10.0,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.50,
                        ),
                        child: AkText(
                          placeHolder ? '' : text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: akFontSize + 1.0,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? akTitleColor
                                : akTitleColor.withOpacity(.31),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: isSelected ? akTitleColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(400.0),
                  ),
                  child: SizedBox(),
                )
              ],
            )),
      ],
    );
  }
}
