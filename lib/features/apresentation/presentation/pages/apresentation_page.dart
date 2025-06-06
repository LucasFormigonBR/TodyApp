import 'package:flutter/material.dart';

class ApresentationPage extends StatelessWidget {
  final String image;
  final List<Widget> texts;
  const ApresentationPage({
    required this.image,
    required this.texts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(top: 10, child: Image.asset(image)),
        Positioned(
          left: -1,
          right: -1,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: texts,
            ),
          ),
        ),
      ],
    );
  }
}
