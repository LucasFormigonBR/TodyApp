import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/presentation/home/cubit/screen_cubit.dart';

import '../../../core/configs/theme/styles_app.dart';
import 'inbox_page.dart';

class CurrentPage extends StatefulWidget {
  final String message;
  const CurrentPage({super.key, required this.message});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  final List<Widget> screens = [const InboxPage(), Container(), Container()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScreenCubit>(
      create: (context) => ScreenCubit(),
      child: BlocBuilder<ScreenCubit, int>(
        builder: (context, indexPage) {
          return Scaffold(
            backgroundColor: StylesApp.greyBackground,
            body: screens[indexPage],
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              currentIndex: indexPage,
              onTap: (index) => context.read<ScreenCubit>().changeScreen(index),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.move_to_inbox_rounded),
                  label: "Inbox",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Agenda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Perfil",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
