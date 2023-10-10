import 'package:app_san_isidro/modules/intro/intro_controller.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  final _conX = Get.put(IntroController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/img/logo_muni.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            _buildCarouselSlider(),
            _buildIndicators(),
            _buildCorner(),
            // _buildSlider(),
          ],
        ),
      ),
    );
  }


  Widget _buildIndicators() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: GetBuilder<IntroController>(
        id: 'gbIndicators',
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lista.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _conX.sliderCtlr.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: akPrimaryColor
                      .withOpacity(_conX.current == entry.key ? 0.9 : 0.25),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    List<Widget> imageSliders = lista.map((item) => _CarouselItem(item)).toList();

    return Padding(
      padding: EdgeInsets.only(top: 90),
      child: Column(
        children: [
          Flexible(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _conX.sliderCtlr,
              options: CarouselOptions(
                scrollPhysics: BouncingScrollPhysics(),
                enableInfiniteScroll: false,
                height: Get.height,
                autoPlay: false,
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: _conX.onPageChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner() {
    return Positioned(
      bottom: 10,
      right: 10,
      left: 0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 5 / 2,
              child: CustomPaint(
                painter: CurveCornerPainter(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: _conX.onNextCornerTap,
              child: Image.asset(
                'assets/img/next_icon.png', // Ruta de la imagen
                width: 50, // Ancho de la imagen
                height: 50, // Alto de la imagen
             // Color de la imagen (opcional)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  final IntroData data;

  const _CarouselItem(this.data);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/img/${data.assetImg}',
                  width: Get.width * .65,
                  height: 150,
                  fit: BoxFit.fitHeight,

                ),
                SizedBox(height: 30.0),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: akContentPadding * 1.65),
                  child: Column(
                    children: [
                      AkText(
                        data.title,
                        textAlign: TextAlign.center,
                        type: AkTextType.subtitle1,
                        style: TextStyle(
                          fontFamily: 'Gisha',
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          height: 1.45,
                          color: akPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      AkText(
                        data.body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Gisha',
                          fontWeight: FontWeight.w300,
                          height: 1.45,
                          color: akTitleColor.withOpacity(.8),
                        ),
                      ),
                      SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroData {
  final String title;
  final String body;
  final String assetImg;


  const IntroData(
      {required this.title, required this.body, required this.assetImg});
}
