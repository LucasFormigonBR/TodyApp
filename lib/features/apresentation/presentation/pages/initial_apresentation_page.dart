import 'package:flutter/material.dart';

class InitialApresentationPage extends StatelessWidget {
  const InitialApresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/images/logo-description.png')),
        ],
      ),
    );
  }
}
