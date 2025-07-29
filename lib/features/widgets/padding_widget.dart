import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  final Widget child;
  const PaddingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: 32,
        right: 32,
        bottom: 16,
        top: 40,
      ),
      child: child,
    );
  }
}
