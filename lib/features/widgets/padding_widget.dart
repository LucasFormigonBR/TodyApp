import 'package:flutter/material.dart';

class PaddingWidget extends StatelessWidget {
  final Widget child;
  const PaddingWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 32, vertical: 16),
      child: child,
    );
  }
}
