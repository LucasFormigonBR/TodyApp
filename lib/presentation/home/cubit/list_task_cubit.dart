import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todyapp/core/configs/functions/functions_date.dart';
import 'package:todyapp/domain/entities/task.dart';
import 'package:todyapp/domain/usecases/add_task.dart';
import 'package:todyapp/presentation/home/cubit/task_state.dart';

import '../../../domain/usecases/get_all_tasks.dart';
import '../../../domain/usecases/remove_multiple_tasks.dart';
import '../../../domain/usecases/remove_task.dart';
import '../../../domain/usecases/update_task.dart';

class ListTaskCubit extends Cubit<ListTaskState> {
  final _dateToday = formatDate(DateTime.now());
  String get dateToday => _dateToday;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  final AddTask _addTask;
  final GetAllTasks _getAllTasks;
  final UpdateTask _updateTask;
  final RemoveTask _removeTask;
  final RemoveMultipleTasks _removeMultipleTasks;

  ListTaskCubit(
    this._addTask,
    this._getAllTasks,
    this._updateTask,
    this._removeTask,
    this._removeMultipleTasks,
  ) : super(TasksInitial([]));

  Future<void> loadTasks(DateTime date) async {
    emit(TasksLoading());

    final result = await _getAllTasks();

    result.fold(
      (exception) {
        emit(TasksError(exception.message!));
      },
      (tasks) {
        _tasks = tasks;
        filterTasksByPeriod(date);
      },
    );
  }

  void filterTasksByPeriod(DateTime date) {
    final selectedDate = formatDate(date);
    final tasksFiltered = _tasks.where((t) => t.date == selectedDate).toList();

    emit(UpdateTasks(tasksFiltered));
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
        emit(TasksError(exception.message!));
      },
      (idNewTask) {
        task = task.copyWith(id: idNewTask);
        _tasks = [..._tasks, task];

        filterTasksByPeriod(DateTime.now());
      },
    );
  }

  Future<void> removeTask(Task task) async {
    final result = await _removeTask(task);

    return result.fold((exception) => emit(TaskError(exception.message!)), (
      success,
    ) {
      _tasks.remove(task);

      filterTasksByPeriod(DateTime.now());
    });
  }

  Future<void> removeTasks(List<Task> tasks) async {
    emit(TasksLoading());

    for (var task in tasks) {
      _tasks = _tasks.where((t) => t.id != task.id).toList();
    }

    final result = await _removeMultipleTasks(tasks);

    result.fold(
      (exception) => emit(TaskError(exception.message!)),
      (success) => filterTasksByPeriod(DateTime.now()),
    );
  }

  Future<void> editTask(Task task) async {
    int index = _tasks.indexWhere((t) => t.id == task.id);

    if (index != -1) {
      _tasks[index] = task;
      final result = await _updateTask(_tasks[index]);

      return result.fold(
        (exception) => emit(TaskError(exception.message!)),
        (success) => filterTasksByPeriod(DateTime.now()),
      );
    }
    emit(TaskError("Tarefa não encontrada"));
  }
}
