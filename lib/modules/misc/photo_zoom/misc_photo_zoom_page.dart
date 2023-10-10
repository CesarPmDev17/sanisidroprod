import 'package:app_san_isidro/modules/misc/photo_zoom/misc_photo_zoom_page_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class MiscPhotoZoomPage extends StatelessWidget {
  final _conX = Get.put(MiscPhotoZoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: akScaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Content(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: akContentPadding * 0.5),
                Row(
                  children: [ArrowBack(onTap: () => Get.back())],
                ),
              ],
            ),
          ),
        ),
      ),
      body: _conX.photoFile != null
          ? PhotoView(
              backgroundDecoration:
                  BoxDecoration(color: akScaffoldBackgroundColor),
              imageProvider: FileImage(_conX.photoFile!),
              maxScale: PhotoViewComputedScale.covered * 2,
              minScale: PhotoViewComputedScale.contained,
            )
          : AkText('Error mostrando imagen.'),
    );
  }
}

/* 
PhotoView(
              backgroundDecoration: BoxDecoration(
                color: akScaffoldBackgroundColor,
              ),
              imageProvider: FileImage(_conX.photoFile!),
              maxScale: PhotoViewComputedScale.covered * 2,
              minScale: PhotoViewComputedScale.contained,
            ) */