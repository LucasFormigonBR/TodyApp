import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginEmailPage extends StatelessWidget {
  const LoginEmailPage({super.key});

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
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your work faster and structured with Todyapp",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 36),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailAddress,
                    decoration: InputDecoration(hintText: "name@example.com"),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => context.go('/create-account'),
                    child: Text("Next"),
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
