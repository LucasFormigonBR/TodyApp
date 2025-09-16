import 'package:equatable/equatable.dart';

import '../../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitialState extends TaskState {
  final List<Task> tasks;

  const TaskInitialState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TasksLoadingState extends TaskState {}

class TasksUpdateState extends TaskState {
  final List<Task> tasks;

  const TasksUpdateState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskSuccessState extends TaskState {
  final String message;

  const TaskSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
