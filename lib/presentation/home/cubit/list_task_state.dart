import 'package:todyapp/domain/entities/task.dart';

abstract class ListTaskState {}

class TasksInitial extends ListTaskState {
  final List<Task> tasks;

  TasksInitial(this.tasks);
}

class TasksToday extends ListTaskState {
  final List<Task> tasks;

  TasksToday(this.tasks);
}

class TasksFiltered extends ListTaskState {
  final List<Task> tasks;

  TasksFiltered(this.tasks);
}

class TasksLoading extends ListTaskState {}

class UpdateTasks extends ListTaskState {
  final List<Task> tasks;

  UpdateTasks(this.tasks);
}

class TasksSelected extends ListTaskState {
  final Task task;

  TasksSelected(this.task);
}

class TasksActivateOptions extends ListTaskState {
  final List<Task> tasks;

  TasksActivateOptions(this.tasks);
}

class TaskSuccess extends ListTaskState {
  final String message;

  TaskSuccess(this.message);
}

class TaskError extends ListTaskState {
  final String message;

  TaskError(this.message);
}

class TasksError extends ListTaskState {
  final String message;

  TasksError(this.message);
}
