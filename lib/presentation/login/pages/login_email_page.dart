import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/presentation/login/cubit/email_cubit.dart';

import '../../../common/helpers/notification.dart';
import '../../../core/service_locator.dart';
import '../cubit/email_state.dart';

class LoginEmailPage extends StatefulWidget {
  final String message;
  const LoginEmailPage({super.key, required this.message});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.getAlertNotification(widget.message, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    final emailAddress = TextEditingController();

    return BlocProvider<EmailCubit>(
      create: (context) => sl<EmailCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<EmailCubit, EmailState>(
            listener: (context, state) {
              if (state is EmailSend) {
                FlashyFlushbar(
                  backgroundColor: Theme.of(context).primaryColor,
                  messageStyle: TextStyle(color: Colors.white, fontSize: 16),
                  leadingWidget: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 24,
                  ),
                  message: 'Link de acesso enviado para seu e-mail!',
                  duration: const Duration(seconds: 5),
                  trailingWidget: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () => FlashyFlushbar.cancel(),
                  ),
                  isDismissible: false,
                ).show();
              }

              if (state is EmailError) {
                ScaffoldMessenger.of(context).showMaterialBanner(
                  MaterialBanner(
                    content: Text('Erro ao enviar: ${state.message}'),
                    backgroundColor: Colors.red,
                    actions: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).hideCurrentMaterialBanner();
                        },
                        child: Text(
                          'Fechar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Form(
              key: form,
              autovalidateMode: AutovalidateMode.always,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Bem-vindo de volta!",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Digite seu e-mail para enviarmos o link de acesso",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 36),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Endereço de e-mail",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: emailAddress,
                        decoration: InputDecoration(
                          hintText: "nome@exemplo.com",
                        ),
                      ),
                      Spacer(),
                      BlocBuilder<EmailCubit, EmailState>(
                        builder: (context, state) {
                          if (state is EmailInitial) {
                            return ElevatedButton(
                              onPressed: () => context
                                  .read<EmailCubit>()
                                  .sendLinkEmail(emailAddress.text),
                              child: Text("Enviar link de acesso"),
                            );
                          }
                          if (state is EmailTimer) {
                            return ElevatedButton(
                              onPressed: null,
                              child: Text(
                                "Aguarde... (${state.secondsRemaining})",
                              ),
                            );
                          }

                          if (state is EmailError) {
                            return ElevatedButton(
                              onPressed: null,
                              child: Text("Enviar link de acesso"),
                            );
                          }

                          return SizedBox.shrink();
                        },
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
