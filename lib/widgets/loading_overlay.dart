part of 'widgets.dart';

class LoadingOverlay extends StatelessWidget {
  final Color color = akScaffoldBackgroundColor;
  final String? errorMessage;
  final void Function()? onRetryTap;
  final double opacityNumber;
  final String? text;
  final int type;

  LoadingOverlay({
    Key? key,
    this.errorMessage,
    this.onRetryTap,
    this.opacityNumber = 0.90,
    this.text,
    this.type = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spinSize = Get.width * 0.20;
    final double factorClip = 0.75;

    return Container(
      color: color.withOpacity(opacityNumber),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            child: errorMessage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      type == 1
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: -spinSize * factorClip,
                                  right: -spinSize * factorClip,
                                  bottom: -spinSize * factorClip,
                                  top: -spinSize * factorClip,
                                  child: Container(
                                    child: Lottie.asset(
                                      'assets/lottie/loading_spin.json',
                                      fit: BoxFit.fill,
                                      delegates: LottieDelegates(
                                        values: [
                                          for (var i in ['1', '2', '3'])
                                            ValueDelegate.strokeColor(
                                                ['Shape Layer $i', '**'],
                                                value: Helpers.lighten(
                                                    akPrimaryColor))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: spinSize,
                                  height: spinSize,
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: akRedColor),
                                      ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      type == 2
                          ? Container(
                              width: Get.width * 0.30,
                              child: Lottie.asset(
                                'assets/lottie/card_loading.json',
                                fit: BoxFit.fill,
                                delegates: LottieDelegates(
                                  values: [
                                    for (var i = 1; i <= 6; i++)
                                      ValueDelegate.strokeColor([
                                        'Shape Layer $i',
                                        '**'
                                      ], value: Helpers.lighten(akPrimaryColor))
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      AkText(
                        text ?? 'Por favor, espere...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: akPrimaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: akFontSize + 2.0,
                        ),
                      ),
                      SizedBox(height: 100.0),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AkText(errorMessage ?? '',
                          style: TextStyle(
                            color: akTitleColor,
                          )),
                      SizedBox(height: 15.0),
                      _RetryButton(onTap: () {
                        onRetryTap?.call();
                      }),
                      SizedBox(height: 100.0),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final void Function()? onTap;
  const _RetryButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          this.onTap?.call();
        },
        borderRadius: BorderRadius.circular(akBtnBorderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: akTitleColor,
              ),
              borderRadius: BorderRadius.circular(akBtnBorderRadius)),
          child: AkText(
            'Reintentar',
            style: TextStyle(
              color: akTitleColor,
            ),
          ),
        ),
      ),
    );
  }
}
