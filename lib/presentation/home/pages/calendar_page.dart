import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';
import 'package:todyapp/common/bloc/task/task_state.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/core/service_locator.dart';

import 'package:todyapp/presentation/home/cubit/calendar/calendar_cubit.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_state.dart';

import '../../../core/configs/assets/images_app.dart';
import '../../../core/configs/functions/functions_date.dart';
import '../../../core/configs/functions/functions_task.dart';
import '../../../core/configs/theme/styles_app.dart';
import '../../../domain/entities/task.dart';
import '../widgets/modal_delete_task.dart';
import '../widgets/modal_task.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final configDate = sl<AppConfig>();
  late final CalendarCubit calendarCubit;
  late final TaskCubit taskCubit;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    calendarCubit = context.read<CalendarCubit>();
    taskCubit = context.read<TaskCubit>();
  }

  @override
  Widget build(BuildContext context) {
    taskCubit.filterTasksByDate(calendarCubit.selectedDate);

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CalendarCubit, CalendarState>(
                  builder: (context, state) {
                    return TextButton(
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
          BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TasksUpdateState) {
                tasks = filterTasksByDate(
                  tasks: state.tasks,
                  date: calendarCubit.selectedDate,
                );
                if (tasks.isEmpty) {
                  return SizedBox.shrink();
                }
                // return Padding(
                //   padding: const EdgeInsets.only(right: 16),
                //   child: Align(
                //     alignment: AlignmentGeometry.centerRight,
                //     child: IconButton.filled(
                //       onPressed: () => filterModal(),
                //       icon: Icon(Icons.filter_alt),
                //     ),
                //   ),
                // );
              }
              return SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TasksLoadingState) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is TasksUpdateState) {
                  if (tasks.isEmpty) {
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
                    itemCount: tasks.length,
                    separatorBuilder: (_, _) => const Divider(),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        leading: Icon(
                          Icons.radio_button_checked,
                          color: task.priority.color,
                        ),
                        title: Row(
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () => showModalOptionsTask(task),
                              icon: Icon(Icons.more_horiz_outlined),
                            ),
                          ],
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
    taskCubit.filterTasksByDate(calendarCubit.selectedDate);
  }

  Future<void> showModalOptionsTask(Task task) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Opções',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Divider(color: Colors.grey[300]),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.deepOrange),
                    title: Text("Editar informações"),
                    onTap: () {
                      Navigator.of(context).pop();
                      showModalEditTask(task);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text("Excluir tarefa"),
                    onTap: () {
                      Navigator.of(context).pop();
                      showModalDeleteTask(task);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showModalEditTask(Task task) async {
    showModalBottomSheet(
      context: context,
      builder: (contextModal) =>
          ModalTask(contextModal: contextModal, isNewTask: false, task: task),
    );
  }

  Future<void> showModalDeleteTask(Task task) async {
    showDialog(
      context: context,
      builder: (contextModal) => ModalDeleteTask(task),
    );
  }

  // Future<void> filterModal() async {
  //   showDialog(context: context, builder: (context) => FilterModalWidget());
  // }
}
