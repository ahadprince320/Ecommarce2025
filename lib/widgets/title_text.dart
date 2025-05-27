import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    Key? key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      textAlign: TextAlign.justify,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }
}
