import 'package:todyapp/domain/entities/task.dart';

abstract class TaskState {}

class TasksInitial extends TaskState {}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TasksSelected extends TaskState {
  final Task task;

  TasksSelected(this.task);
}

class TasksActivateOptions extends TaskState {
  final List<Task> tasks;

  TasksActivateOptions(this.tasks);
}

class TasksError extends TaskState {
  final String message;

  TasksError(this.message);
}
