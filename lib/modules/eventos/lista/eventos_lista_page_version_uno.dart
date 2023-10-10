import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventosListaVersionUnoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lista = <Widget>[];
    final lista2 = <Widget>[];

    for (var i = 17; i < 25; i++) {
      lista.add(_DateSlideBtn(day: '$i', selected: i == 17));
      lista2.add(_EventListItem(
        day: '$i',
        alternate: !(i % 2 == 0),
      ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(
            top: akContentPadding * 0.5,
            left: akContentPadding,
            right: akContentPadding,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArrowBack(onTap: () => Get.back()),
                AppBarTitle('Eventos'),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: lista,
                  ),
                ),
                SizedBox(height: 20.0),
                SectionTitle('Listado'),
                ...lista2,
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateSlideBtn extends StatelessWidget {
  final String day;
  final bool selected;

  _DateSlideBtn({required this.day, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.0),
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: selected ? akPrimaryColor : Colors.black.withOpacity(.02),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          SizedBox(height: 7.0),
          AkText(
            day,
            style: TextStyle(
              color: selected ? akWhiteColor : akTitleColor,
              fontSize: akFontSize + 6.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          AkText(
            'OCT',
            style: TextStyle(
              color: selected ? akWhiteColor : akTitleColor,
              fontSize: akFontSize - 2.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          AkText(
            '.',
            style: TextStyle(
              color: selected ? akWhiteColor : akTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventListItem extends StatelessWidget {
  final String day;
  final bool alternate;

  _EventListItem({required this.day, this.alternate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: Container(
          width: double.infinity,
          // margin: EdgeInsets.only(right: 6.0),
          // padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 18.0),
          decoration: BoxDecoration(
            color: akWhiteColor,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  color: alternate ? akAccentColor : akPrimaryColor,
                  width: 6.0,
                ),
                Container(
                  width: 75.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AkText(
                        day,
                        style: TextStyle(
                          color: akTitleColor,
                          fontSize: akFontSize + 21.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AkText(
                        'OCT',
                        style: TextStyle(
                          color: akTitleColor,
                          fontSize: akFontSize - 2.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 17.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AkText(
                              'Hora:    ',
                              style: TextStyle(
                                color: akTitleColor.withOpacity(.67),
                                fontSize: akFontSize - 2.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: AkText(
                                '02:00 - 17:00',
                                style: TextStyle(
                                  fontSize: akFontSize - 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          child: AkText(
                            'Evento de inauguración del un local municipal en la dirección Av. San Isidro 24. Se contará con la presencia del alcalde',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
