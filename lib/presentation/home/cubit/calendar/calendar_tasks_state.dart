import '../../../../domain/entities/task.dart';

abstract class CalendarTasksState {}

class CalendarGetTasks extends CalendarTasksState {
  List<Task> tasks = [];

  CalendarGetTasks(this.tasks);
}
