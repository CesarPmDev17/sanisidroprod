part of 'widgets.dart';

class ImageFade extends StatelessWidget {
  final Color backgrondColor;
  final String imageUrl;
  final double height;
  final double width;

  ImageFade(
      {this.backgrondColor = const Color(0xFFECECEC),
      required this.imageUrl,
      this.height = 200.0,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: height,
        width: width,
        color: backgrondColor,
      ),
      FadeInImage.memoryNetwork(
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: kTransparentImage,
        imageErrorBuilder: (_, __, ___) => Container(
          height: height,
          width: width,
          color: backgrondColor,
          child: Center(
            child: Icon(
              Icons.error,
              size: akFontSize + 15.0,
              color: Colors.grey.withOpacity(.2),
            ),
          ),
        ),
        image: imageUrl,
      )
    ]);
  }
}
