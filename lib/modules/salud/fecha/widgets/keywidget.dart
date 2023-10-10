import 'dart:math';

import 'package:flutter/material.dart';

class StatelessColorfulTile extends StatefulWidget {
  @override
  State<StatelessColorfulTile> createState() {
    print('creando state');
    return _StatelessColorfulTileState();
  }
}

class _StatelessColorfulTileState extends State<StatelessColorfulTile> {
  final Color myColor = UniqueColorGenerator.getColor();

  @override
  Widget build(BuildContext context) {
    print('buildddd');
    return Container(
        color: myColor, child: Padding(padding: EdgeInsets.all(70.0)));
  }
}

class UniqueColorGenerator {
  static List colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.black,
  ];
  static Random random = new Random();
  static Color getColor() {
    if (colorOptions.length > 0) {
      return colorOptions.removeAt(random.nextInt(colorOptions.length));
    } else {
      return Color.fromARGB(random.nextInt(256), random.nextInt(256),
          random.nextInt(256), random.nextInt(256));
    }
  }
}
