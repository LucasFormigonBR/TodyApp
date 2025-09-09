import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/core/service_locator.dart';

import 'package:todyapp/presentation/home/cubit/calendar/calendar_cubit.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_state.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_tasks_cubit.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_tasks_state.dart';
import 'package:todyapp/presentation/home/cubit/task_state.dart';

import '../../../core/configs/assets/images_app.dart';
import '../../../core/configs/functions/functions_date.dart';
import '../../../core/configs/theme/styles_app.dart';
import '../cubit/list_task_cubit.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final configDate = sl<AppConfig>();
  late final CalendarCubit calendarCubit;
  late final ListTaskCubit listTaskCubit;
  late final CalendarTasksCubit calendarTasksCubit;

  @override
  void initState() {
    super.initState();
    calendarCubit = context.read<CalendarCubit>();
    listTaskCubit = context.read<ListTaskCubit>();
    calendarTasksCubit = context.read<CalendarTasksCubit>();
    listTaskCubit.filterTasksByPeriod(calendarCubit.selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Agenda", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CalendarCubit, CalendarState>(
                  builder: (context, state) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        elevation: 5,
                        shadowColor: Colors.grey.shade100,
                        backgroundColor: Colors.teal.shade100,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(width: 6),
                          Text(nameMonthAndYear(calendarCubit.selectedDate)),
                        ],
                      ),
                      onPressed: () async {
                        await chooseDate();
                        updateListTasks(calendarCubit.selectedDate);
                      },
                    );
                  },
                ),
                TextButton(
                  onPressed: () => updateListTasks(DateTime.now()),
                  child: const Text(
                    "Hoje",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),

          // Calendário horizontal
          SizedBox(
            height: 90,
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                final selectedMonth = calendarCubit.selectedDate.month;
                final selectedYear = calendarCubit.selectedDate.year;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth(
                    month: calendarCubit.selectedDate.month,
                    year: calendarCubit.selectedDate.year,
                  ),
                  itemBuilder: (context, index) {
                    int day = index + 1;
                    final weekDays = weekDaysName();
                    final weekDay = weekDays[index % 7];

                    final isSelected = day == calendarCubit.selectedDate.day;
                    final selectedDate = DateTime(
                      selectedYear,
                      selectedMonth,
                      day,
                    );

                    return GestureDetector(
                      onTap: () => updateListTasks(selectedDate),
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weekDay,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              day.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          BlocBuilder<CalendarTasksCubit, CalendarTasksState>(
            builder: (context, state) {
              if (state is CalendarGetTasks) {
                if (state.tasks.isEmpty) {
                  return SizedBox.shrink();
                }
                return IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt),
                );
              }
              return SizedBox.shrink();
            },
          ),

          // Lista de eventos
          Expanded(
            child: BlocBuilder<ListTaskCubit, ListTaskState>(
              builder: (context, state) {
                if (state is UpdateTasks) {
                  if (state.tasks.isEmpty) {
                    return Opacity(
                      opacity: 0.5,
                      child: Center(
                        child: Image.asset(
                          ImagesApp.emptyListTasks,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: state.tasks.length,
                    separatorBuilder: (_, _) => const Divider(),
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: Icon(
                          Icons.radio_button_checked,
                          color: task.priority.color,
                        ),
                        title: Text(
                          task.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.hours,
                                  style: TextStyle(color: StylesApp.greyText),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.date,
                                  style: const TextStyle(
                                    color: StylesApp.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            task.description.isNotEmpty
                                ? Row(
                                    children: [
                                      const Icon(Icons.comment, size: 16),
                                      const SizedBox(width: 4),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  Future<void> chooseDate() async {
    DateTime initialDate = calendarCubit.selectedDate;

    DateTime? chosenDate = await showDatePicker(
      confirmText: "Confirmar",
      context: context,
      initialDate: initialDate,
      firstDate: configDate.firstDate,
      lastDate: configDate.lastDate,
    );

    if (chosenDate == null) return;

    calendarCubit.saveSelectedDate(chosenDate);
  }

  void updateListTasks(DateTime selectedDate) {
    calendarCubit.saveSelectedDate(selectedDate);
    listTaskCubit.filterTasksByPeriod(calendarCubit.selectedDate);
  }
}
