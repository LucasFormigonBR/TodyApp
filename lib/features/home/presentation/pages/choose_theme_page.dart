import 'package:flutter/material.dart';
import 'package:todyapp/features/widgets/padding_widget.dart';

class ChooseThemePage extends StatelessWidget {
  const ChooseThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaddingWidget(child: Column(children: [])),
      ),
    );
  }
}
