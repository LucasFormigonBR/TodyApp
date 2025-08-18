import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/core/configs/theme/styles_app.dart';

import '../../../common/helpers/notification.dart';
import '../cubit/apresentation_cubit.dart';
import 'apresentation_page.dart';
import 'initial_apresentation_page.dart';

class ApresentationStructurePage extends StatefulWidget {
  final String message;
  ApresentationStructurePage({super.key, required this.message});

  @override
  State<ApresentationStructurePage> createState() =>
      _ApresentationStructurePageState();
}

class _ApresentationStructurePageState
    extends State<ApresentationStructurePage> {
  late PageController _pageController;
  late ApresentationCubit _cubit;

  @override
  void initState() {
    super.initState();
    NotificationHelper.getAlertNotification(widget.message, color: Colors.red);
    _cubit = context.read<ApresentationCubit>();
    _pageController = PageController(initialPage: _cubit.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApresentationCubit, int>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: scaffoldBackgroundColor(),
          appBar: AppBar(actions: [skipButtonVisibility()]),
          body: Padding(
            padding: StylesApp.defaultPaddingHorizontal,
            child: Column(
              children: [
                Flexible(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _cubit.totalPages,
                    onPageChanged: (index) => _cubit.updatePage(page: index),
                    itemBuilder: (context, indexPage) {
                      switch (indexPage) {
                        case 0:
                          return InitialApresentationPage();
                        case 1:
                          return ApresentationPage(
                            image: 'assets/images/phone-1.png',
                            texts: [
                              Text(
                                "Sua conveniência em",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "fazer lista de coisas a fazer",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Aqui esta uma plataforma móvel que facilita a criação e organização de tarefas, ajudando você a realizar cada atividade de forma mais simples e eficiente.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        case 2:
                          return ApresentationPage(
                            image: 'assets/images/phone-2.png',
                            texts: [
                              Text(
                                "Encontre a praticidade em",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "fazer sua lista de atividades",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "A interface do usuário deixa fácil de entender, o que deixa você mais confortável quando você quer criar uma tarefa ou para fazer a lista.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                "Todyapp também pode melhorar a produtividade.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        default:
                          return Container(color: Colors.white);
                      }
                    },
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    _cubit.totalPages,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: _cubit.currentPage == index ? 32 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: stepColor(
                          currentPage: _cubit.currentPage,
                          indexPage: index,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                continueButtonVisibility(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color scaffoldBackgroundColor() {
    return _cubit.currentPage == 0
        ? Theme.of(context).primaryColor
        : Colors.white;
  }

  Color stepColor({required int currentPage, required int indexPage}) {
    if (currentPage == 0) {
      return Colors.white;
    }
    return currentPage == indexPage
        ? Theme.of(context).primaryColor
        : StylesApp.disabled;
  }

  Widget skipButtonVisibility() {
    return _cubit.currentPage == 0
        ? SizedBox.shrink()
        : TextButton(
            onPressed: () => context.go('/login'),
            child: Text(
              "Pular",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: StylesApp.textButtonFontWeight,
              ),
            ),
          );
  }

  Widget continueButtonVisibility() {
    return _cubit.currentPage == 0
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_cubit.currentPage < _cubit.totalPages - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  return;
                }
                context.go('/login');
              },
              child: const Text("Continuar"),
            ),
          );
  }
}
