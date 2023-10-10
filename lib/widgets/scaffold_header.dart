part of 'widgets.dart';

class ScaffoldHeader extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconData;

  const ScaffoldHeader({
    Key? key,
    this.title = '',
    this.subTitle = '',
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsize = akFontSize + 18.0;
    final fheight = fsize * 0.028;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: akPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50.0),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: akContentPadding * .35),
                Content(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ArrowBack(
                        onTap: () async {
                          Get.back();
                        },
                        color: akWhiteColor,
                      ),
                      LogoMuni(
                        whiteMode: true,
                        size: Get.width * 0.22,
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: ArrowBack(
                          onTap: () async {},
                          color: akWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: akContentPadding * .8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: akContentPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5.0),
                          AkText(
                            title,
                            style: TextStyle(
                              color: akWhiteColor,
                              fontWeight: FontWeight.w900,
                              fontSize: fsize,
                              fontStyle: FontStyle.italic,
                              height: fheight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (iconData != null)
                            Icon(
                              iconData!,
                              color: akWhiteColor,
                              size: fsize,
                            ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: AkText(
                              subTitle,
                              style: TextStyle(
                                color: akAccentColor,
                                fontWeight: FontWeight.w900,
                                fontSize: fsize,
                                fontStyle: FontStyle.italic,
                                height: fheight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: akContentPadding),
              ],
            ),
          ),
        ),
        /* Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: akContentPadding * 0.5,
            horizontal: akContentPadding,
          ),
          child: AkText(
            '_conX.mapName',
            style: TextStyle(
              color: akPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: fsize - 10.0,
              fontStyle: FontStyle.italic,
              height: fheight,
            ),
          ),
        ), */
      ],
    );
  }
}
