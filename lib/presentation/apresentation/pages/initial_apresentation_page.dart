import 'package:flutter/material.dart';

import '../../../core/configs/assets/images_app.dart';

class InitialApresentationPage extends StatelessWidget {
  const InitialApresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(children: [Expanded(child: Image.asset(ImagesApp.logo))]),
    );
  }
}
