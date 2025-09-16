import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todyapp/core/configs/constants/filters.dart';
import 'package:todyapp/domain/usecases/task/get_all_tasks.dart';

import '../../../core/configs/functions/functions_date.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/task/add_task.dart';
import '../../../domain/usecases/task/remove_multiple_tasks.dart';
import '../../../domain/usecases/task/update_task.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasks _getAllTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final RemoveMultipleTasks _removeMultipleTasks;

  TaskCubit(
    this._getAllTasks,
    this._addTask,
    this._updateTask,
    this._removeMultipleTasks,
  ) : super(TaskInitialState([]));

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> getTasks() async {
    emit(TasksLoadingState());
    final result = await _getAllTasks();

    result.fold((failure) => emit(TaskErrorState(failure.message!)), (
      allTasks,
    ) {
      _tasks = allTasks;
      emit(TasksUpdateState(allTasks));
    });
  }

  void selectFilterTask(FilterTask filterSelected) {
    switch (filterSelected) {
      case FilterTask.titulo:
        break;
      case FilterTask.data:
        break;
      case FilterTask.hora:
        break;
    }
  }

  void filterTasksByDate(DateTime date) {
    final selectedDate = formatDate(date);
    final tasksFiltered = _tasks.where((t) => t.date == selectedDate).toList();

    emit(TasksUpdateState(tasksFiltered));
  }

  Future<void> addTask(Task task) async {
    if (task.date.isEmpty) {
      DateTime todayDate = DateTime.now();
      task = task.copyWith(date: DateFormat('dd/MM/yyyy').format(todayDate));
    }

    if (task.hours.isEmpty) {
      TimeOfDay horaryNow = TimeOfDay.now();
      final hours = horaryNow.hour.toString().padLeft(2, "0");
      final minutes = horaryNow.minute.toString().padLeft(2, "0");
      task = task.copyWith(hours: "${hours}h$minutes");
    }

    final result = await _addTask(task);

    result.fold(
      (exception) {
        emit(TaskErrorState(exception.message!));
      },
      (idNewTask) {
        task = task.copyWith(id: idNewTask);
        _tasks = [..._tasks, task];
        emit(TasksUpdateState(_tasks));
      },
    );
  }

  Future<void> removeTasks(List<Task> tasksSelected) async {
    final tasksToRemove = tasksSelected.map((t) => t.id).toSet();
    _tasks = _tasks.where((t) => !tasksToRemove.contains(t.id)).toList();
    final result = await _removeMultipleTasks(tasksSelected);

    result.fold(
      (exception) => emit(TaskErrorState(exception.message!)),
      (success) => emit(TasksUpdateState(_tasks)),
    );
  }

  Future<void> editTask(Task task) async {
    int index = _tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      _tasks[index] = task;
      emit(TasksLoadingState());
      final result = await _updateTask(_tasks[index]);

      return result.fold(
        (exception) => emit(TaskErrorState(exception.message!)),
        (success) => emit(TasksUpdateState(_tasks)),
      );
    }
    emit(TaskErrorState("Tarefa não encontrada"));
  }
}
