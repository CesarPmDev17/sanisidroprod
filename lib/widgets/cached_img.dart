import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImg extends StatelessWidget {
  final String imageUrl;

  CachedImg({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => Container(
        color: const Color(0xFFECECEC),
        child: Center(
          child: Icon(
            Icons.error,
            size: akFontSize + 15.0,
            color: Colors.grey.withOpacity(.2),
          ),
        ),
      ),
    );
  }
}
