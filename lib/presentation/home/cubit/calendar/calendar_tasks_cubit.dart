import 'package:bloc/bloc.dart';
import 'package:todyapp/presentation/home/cubit/calendar/calendar_tasks_state.dart';

import '../../../../domain/entities/task.dart';

class CalendarTasksCubit extends Cubit<CalendarTasksState> {
  CalendarTasksCubit() : super(CalendarGetTasks([]));

  void loadTasksForDate({required List<Task> tasks, required String date}) {
    List<Task> tasksFiltered = [];

    for (Task task in tasks) {
      if (task.date == date) {
        tasksFiltered.add(task);
      }
    }

    if (tasksFiltered.isEmpty) {
      return emit(CalendarGetTasks([]));
    }
    emit(CalendarGetTasks(tasksFiltered));
  }
}
