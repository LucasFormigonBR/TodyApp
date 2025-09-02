import 'package:todyapp/domain/entities/task.dart';

abstract class TaskState {}

class TasksInitial extends TaskState {
  final List<Task> tasks;

  TasksInitial(this.tasks);
}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;
  final bool error;

  TasksLoaded(this.tasks, {this.error = false});
}

class TasksSelected extends TaskState {
  final Task task;

  TasksSelected(this.task);
}

class TasksActivateOptions extends TaskState {
  final List<Task> tasks;

  TasksActivateOptions(this.tasks);
}

class TaskSuccess extends TaskState {
  final String message;

  TaskSuccess(this.message);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class TasksError extends TaskState {
  final String message;

  TasksError(this.message);
}
