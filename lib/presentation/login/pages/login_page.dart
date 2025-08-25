import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/core/configs/assets/images_app.dart';
import 'package:todyapp/presentation/login/cubit/login_cubit.dart';
import 'package:todyapp/presentation/login/cubit/login_state.dart';

import '../../../common/helpers/notification.dart';
import '../../../core/configs/theme/styles_app.dart';
import '../../../core/service_locator.dart';

class LoginPage extends StatefulWidget {
  final message;
  const LoginPage({super.key, required this.message});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.getAlertNotification(widget.message, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) => sl<LoginCubit>(),
      child: Builder(
        builder: (context) {
          final loginCubit = context.read<LoginCubit>();

          return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                NotificationHelper.getAlertNotification(
                  state.error,
                  color: Colors.red,
                );
              }
              if (state is LoginSuccess) {
                context.go('/details-todyapp');
              }
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          text: "Bem-vindo ao",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: StylesApp.colorDefaultText,
                          ),
                          children: [
                            TextSpan(
                              text: " Todyapp",
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: StylesApp.textButtonFontWeight,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(ImagesApp.phone3),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) {
                            if (current is LoginSuccess) {
                              return false;
                            }
                            return true;
                          },
                          builder: (context, state) {
                            if (state is LoginInitial) {
                              return ElevatedButton(
                                onPressed: () => context.go('/login-email'),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email, size: 24.0),
                                    SizedBox(width: 8.0),
                                    Text("Continuar com e-mail"),
                                  ],
                                ),
                              );
                            }

                            if (state is LoginLoading) {
                              return ElevatedButton(
                                onPressed: null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email, size: 24.0),
                                    SizedBox(width: 8.0),
                                    Text("Continuar com e-mail"),
                                  ],
                                ),
                              );
                            }

                            if (state is LoginFailure) {
                              return ElevatedButton(
                                onPressed: () => context.go('/login-email'),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email, size: 24.0),
                                    SizedBox(width: 8.0),
                                    Text("Continuar com e-mail"),
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              height: 1.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                          ),
                          Text(
                            "ou continue com",
                            style: TextStyle(color: StylesApp.greyText),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              height: 1.0,
                              indent: 20.0,
                              endIndent: 20.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (previous, current) {
                                if (current is LoginSuccess) {
                                  return false;
                                }
                                return true;
                              },
                              builder: (context, state) {
                                if (state is LoginInitial) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGithub,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Github",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () =>
                                        loginCubit.authenticateWithGithub(),
                                  );
                                }

                                if (state is LoginLoading) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    onPressed: null,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGithub,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Github",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                if (state is LoginFailure) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGithub,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Github",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  );
                                }

                                return SizedBox.shrink();
                              },
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: BlocBuilder<LoginCubit, LoginState>(
                              buildWhen: (previous, current) {
                                if (current is LoginSuccess) {
                                  return false;
                                }
                                return true;
                              },
                              builder: (context, state) {
                                if (state is LoginInitial) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGoogle,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Google",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () =>
                                        loginCubit.authenticateWithGoogle(),
                                  );
                                }

                                if (state is LoginLoading) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    onPressed: null,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGoogle,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Google",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                if (state is LoginFailure) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImagesApp.iconGoogle,
                                          width: 24,
                                          height: 24,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          "Google",
                                          style: StylesApp.textButtonBold(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () =>
                                        loginCubit.authenticateWithGoogle(),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
