import 'package:flutter/material.dart';

class subtitlewidgets  extends StatelessWidget {
  const subtitlewidgets ({
    super.key,
    required this.label,
    this.fontSize = 18.0,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textDecoration = TextDecoration.none,
  });

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {

    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
