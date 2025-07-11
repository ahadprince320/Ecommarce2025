import 'package:ecommarceproject/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import '../../Screens/SearchScreen.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
  });

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 5,
          ),
          subtitlewidgets(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
