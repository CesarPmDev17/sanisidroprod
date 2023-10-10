import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ItemModulo {
  final String title;
  final FontWeight? textFontWeight;
  final String desc;
  final Color? bgColor;
  final Color? boxShadowColor;
  final Widget? icon;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool isPublic;

  ItemModulo({
    this.title = '',
    this.textFontWeight,
    this.desc = '',
    this.bgColor,
    this.boxShadowColor,
    this.icon,
    this.onTap,
    this.maxLines = 2,
    this.isPublic = false,
  });
}
