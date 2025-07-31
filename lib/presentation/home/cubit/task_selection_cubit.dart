import 'package:bloc/bloc.dart';
import 'package:todyapp/presentation/home/cubit/task_selection_state.dart';

import '../../../domain/entities/task.dart';

class TaskSelectionCubit extends Cubit<TaskSelectionState> {
  TaskSelectionCubit() : super(TaskSelectionUpdate([]));

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void clearSelectionList() {
    _tasks = [];
    emit(TaskSelectionUpdate(_tasks));
  }

  void addOrRemoveCheck(Task task) {
    final alreadySelected = _tasks.any((t) => t.id == task.id);

    if (alreadySelected) {
      _tasks = _tasks.where((t) => t.id != task.id).toList();
      emit(TaskSelectionUpdate(List.from(_tasks)));
      return;
    }
    _tasks.add(task);

    emit(TaskSelectionUpdate(List.from(_tasks)));
  }

  void selectAllTasks(List<Task> allTasks) {
    if (_tasks.isNotEmpty) {
      _tasks.clear();
      emit(TaskSelectionUpdate(_tasks));
      return;
    }
    _tasks = List.from(allTasks);
    emit(TaskSelectionUpdate(_tasks));
  }
}
