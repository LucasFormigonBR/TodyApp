import 'package:flutter/material.dart';

import '../../../../core/constants/styles_app.dart';

class StepSwipeScreen extends StatefulWidget {
  const StepSwipeScreen({super.key});

  @override
  State<StepSwipeScreen> createState() => _StepSwipeScreenState();
}

class _StepSwipeScreenState extends State<StepSwipeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Skip",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: StylesApp.textButtonFontWeight,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 10,
                        child: SizedBox(
                          child: Image.asset('assets/images/phone-1.png'),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 15,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              _totalPages,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: _currentPage == index ? 32 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : StylesApp.disabled,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
