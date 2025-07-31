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
                  "Criando lista de tarefas",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(
                  "Defina as prioridades de cada tarefa como preferir",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(height: 32),
                Expanded(child: Image.asset(ImagesApp.themesCard)),
                SizedBox(height: 40),
                ElevatedButton(
                  child: Text("Abrir o Todyapp"),
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
