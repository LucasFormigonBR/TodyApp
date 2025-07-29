import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todyapp/features/home/domain/entities/task.dart';
import 'package:todyapp/features/home/presentation/cubit/task_state.dart';

class ListTaskCubit extends Cubit<TaskState> {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  List<Task> _selectedTasks = [];
  List<Task> get selectedTasks => _selectedTasks;

  ListTaskCubit() : super(TasksInitial());

  void addTask(Task task) async {
    emit(TasksLoading());

    Random random = Random();

    task = task.copyWith(id: random.nextInt(100) + 1);

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

    _tasks.add(task);

    emit(TasksLoaded(_tasks));
  }

  void removeTask(int index) async {
    emit(TasksLoading());

    await Future.delayed(const Duration(seconds: 1));

    _tasks.removeAt(index);

    emit(TasksLoaded(_tasks));
  }

  Future<void> removeTasks(List<Task> tasks) async {
    emit(TasksLoading());

    await Future.delayed(const Duration(seconds: 1));

    for (var task in tasks) {
      _tasks = _tasks.where((t) => t.id != task.id).toList();
    }

    emit(TasksLoaded(_tasks));
  }

  Future<void> editTask(Task task) async {
    emit(TasksLoading());

    await Future.delayed(const Duration(seconds: 1));

    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      emit(TasksLoaded(_tasks));
    } else {
      emit(TasksError("Task not found"));
    }
  }
}
