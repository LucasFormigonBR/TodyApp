import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/core/constants/images_app.dart';
import 'package:todyapp/features/widgets/padding_widget.dart';

class ChooseThemePage extends StatelessWidget {
  const ChooseThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaddingWidget(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Create to do list",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  "Choose your to do list color theme:",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 32),
                Expanded(
                  child: Image.asset(ImagesApp.themesCard),

                  // ListView.builder(
                  //   itemCount: 4,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text("Teste"),
                  //       style: ListTileStyle.drawer,
                  //       splashColor: Colors.red,
                  //     );
                  //   },
                  // ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  child: Text("Open Todyapp"),
                  onPressed: () => context.go('/home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
