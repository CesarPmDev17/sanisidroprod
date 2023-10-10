part of 'widgets.dart';

class PhotoItem extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets paddingWrap;
  final Radius dottedBorderRadius;
  final Color dottedBorderColor;
  final List<double> dashPattern;
  final double strokeWidth;
  final Color? photoBackgroundColor;
  final File? file;
  final void Function()? onRemoveTap;
  final void Function()? onCameraTap;
  final void Function()? onGalleryTap;
  final void Function()? onPhotoTap;
  final bool hideClose;

  const PhotoItem({
    this.padding = const EdgeInsets.all(5.0),
    this.paddingWrap = const EdgeInsets.all(5.0),
    this.dottedBorderRadius = const Radius.circular(6),
    this.dottedBorderColor = const Color(0xFFCFCFCF),
    this.dashPattern = const <double>[6, 6],
    this.strokeWidth = 1.0,
    this.photoBackgroundColor,
    this.file,
    this.onRemoveTap,
    this.onCameraTap,
    this.onGalleryTap,
    this.onPhotoTap,
    this.hideClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        _elementImagePicker(),
        this.file != null && !hideClose ? _deleteButton() : SizedBox(),
      ],
    );
  }

  Widget _deleteButton() {
    double _size = 22;
    return Positioned(
        right: 0.0,
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Material(
              elevation: 4,
              color: akPrimaryColor, // button color
              child: InkWell(
                splashColor: akPrimaryColor, // inkwell color
                child: SizedBox(
                    width: _size,
                    height: _size,
                    child: Icon(
                      Icons.clear,
                      size: 15,
                      color: Colors.white,
                    )),
                onTap: this.onRemoveTap != null ? this.onRemoveTap : () {},
              ),
            ),
          ),
        ));
  }

  Widget _elementImagePicker() {
    return Padding(
      padding: this.paddingWrap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: this.dottedBorderRadius,
        padding: this.padding,
        color: this.dottedBorderColor,
        dashPattern: this.dashPattern,
        strokeWidth: this.strokeWidth,
        child: GestureDetector(
          onTap: this.file != null
              ? this.onPhotoTap
              : () async {
                  final resp = await Get.dialog(
                      AlertDialog(
                        contentPadding: EdgeInsets.all(0.0),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        content: Container(
                          width: 1000.0,
                          constraints:
                              BoxConstraints(minHeight: 10.0, maxHeight: 300.0),
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(akRadiusGeneral)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AkText('Selecciona alguna de estas opciones:'),
                              SizedBox(height: 15.0),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: AkButton(
                                    onPressed: () {
                                      Get.back(result: 1);
                                    },
                                    text: 'Cámara',
                                    fluid: true,
                                    enableMargin: false,
                                  )),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                      child: AkButton(
                                    onPressed: () {
                                      Get.back(result: 2);
                                    },
                                    text: 'Galería',
                                    fluid: true,
                                    enableMargin: false,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      barrierColor: Colors.black.withOpacity(0.35));

                  if (resp == 1) {
                    this.onCameraTap?.call();
                  } else if (resp == 2) {
                    this.onGalleryTap?.call();
                  }
                },
          child: Container(
            color: this.photoBackgroundColor ?? Color(0xFFE9E7F2),
            width: double.infinity,
            height: double.infinity,
            child: _generateChild(),
          ),
        ),
      ),
    );
  }

  Widget _generateChild() {
    if (this.file != null) {
      return Image.file(this.file!, fit: BoxFit.cover);
    } else {
      return Center(
        child: Icon(Icons.add, color: Color(0xFFB7B7B7)),
      );
    }
  }
}
