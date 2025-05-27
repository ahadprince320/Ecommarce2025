import 'package:ecommarceproject/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNameText extends StatelessWidget {

  const AppNameText({super.key, this.fontSize=30});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(seconds: 5 ),
        child: TitlesTextWidget(label: "Shop smart",fontSize: fontSize,), baseColor: Colors.purple, highlightColor: Colors.red);
  }
}
