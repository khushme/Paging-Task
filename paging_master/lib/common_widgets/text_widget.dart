import 'package:flutter/material.dart';
import 'package:paging_master/constants/colors.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final int maxLines;
  TextWidget(
      {@required this.label,
      @required this.fontSize,
      this.maxLines,
      this.textAlign,
      this.color = AppColors.black,
      this.fontWeight = FontWeight.normal});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
          color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
