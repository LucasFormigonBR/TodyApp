import '../../domain/entities/task.dart';

abstract class TaskSelectionState {}

class TaskSelectionUpdate extends TaskSelectionState {
  final List<Task> selectedTasks;

  TaskSelectionUpdate(this.selectedTasks);
}
