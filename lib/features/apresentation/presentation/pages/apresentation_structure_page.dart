import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/features/apresentation/presentation/cubit/apresentation_cubit.dart';
import 'package:todyapp/features/apresentation/presentation/pages/initial_apresentation_page.dart';

import '../../../../core/constants/style.dart';
import 'apresentation_page.dart';

class ApresentationStructurePage extends StatefulWidget {
  ApresentationStructurePage({super.key});

  @override
  State<ApresentationStructurePage> createState() =>
      _ApresentationStructurePageState();
}

class _ApresentationStructurePageState
    extends State<ApresentationStructurePage> {
  final PageController _pageController = PageController();
  late ApresentationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ApresentationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApresentationCubit, int>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: scaffoldBackgroundColor(),
          appBar: AppBar(actions: [skipButtonVisibility()]),
          body: Column(
            children: [
              Flexible(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _cubit.totalPages,
                  onPageChanged: (index) => _cubit.updatePage(page: index),
                  //_currentPage = index,
                  itemBuilder: (context, indexPage) {
                    switch (indexPage) {
                      case 0:
                        return InitialApresentationPage();
                      case 1:
                        return ApresentationPage(
                          image: 'assets/images/phone-1.png',
                          texts: [
                            Text(
                              "Your convenience in",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "making a todo list",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Here's a mobile platform that helps you create task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "or to list so that it can help you in every job",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "easier and faster.",
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
                              "Find the practicality in",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "making your todo list",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Easy-to-understand user interface that makes you",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "more comfortable when you want to create a task or",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "to do list, Todyapp can also improve productivity.",
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
                      //cubit.currentPage == index
                      //     ? Theme.of(context).primaryColor
                      //     : StyleApp.disabled,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              continueButtonVisibility(),
            ],
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
        : StyleApp.disabled;
  }

  Widget skipButtonVisibility() {
    return _cubit.currentPage == 0
        ? SizedBox.shrink()
        : TextButton(
            onPressed: () => context.go(
              '/login',
            ), //Navigator.pushReplacementNamed(context, '/home'),
            child: Text(
              "Skip",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: StyleApp.textButtonFontWeight,
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
              child: const Text("Continue"),
            ),
          );
  }
}
