import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    final emailAddress = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Criando conta",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Crie sua conta e sinta os benefícios",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 36),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nome de usuário",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailAddress,
                    decoration: InputDecoration(
                      hintText: "Digite seu nome de usuário",
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Senha",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailAddress,
                    decoration: InputDecoration(hintText: "Digite sua senha"),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => context.go('/details-todyapp'),
                    child: Text("Criar conta"),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
