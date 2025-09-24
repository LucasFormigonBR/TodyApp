import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_tasks_cubit.dart';
import 'package:todyapp/presentation/home/cubit/profile/profile_cubit.dart';
import 'package:todyapp/presentation/home/cubit/screen_cubit.dart';
import 'package:todyapp/presentation/home/pages/calendar_page.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';

import '../../../core/service_locator.dart';
import '../cubit/button_cubit.dart';
import '../cubit/calendar/calendar_cubit.dart';
import '../cubit/mode_checkbox_cubit.dart';
import '../cubit/task_selection_cubit.dart';
import 'inbox_page.dart';
import 'profile_page.dart';

class CurrentPage extends StatefulWidget {
  final String message;
  const CurrentPage({super.key, required this.message});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  final List<Widget> screens = [
    const InboxPage(),
    CalendarPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScreenCubit()),
        BlocProvider(create: (context) => ModeCheckboxCubit()),
        BlocProvider(create: (context) => TaskSelectionCubit()),
        BlocProvider(create: (context) => ButtonCubit()),
        BlocProvider(create: (context) => CalendarCubit()),
        BlocProvider(create: (context) => CalendarTasksCubit()),
        BlocProvider(create: (context) => sl<ProfileCubit>()),
        BlocProvider(create: (context) => sl<TaskCubit>()..getTasks()),
      ],
      child: BlocBuilder<ScreenCubit, int>(
        builder: (context, indexPage) {
          return Scaffold(
            backgroundColor: Colors.white,
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
