import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todyapp/data/datasources/task_datasource.dart';
import 'package:todyapp/data/models/task_model.dart';
import 'package:todyapp/domain/repositories/task_repository.dart';

import '../../domain/entities/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final dataSource = TaskDataSource();

  @override
  Future<Either<FirebaseException, String>> addTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      return Right(await dataSource.add(taskModel));
    } on FirebaseException catch (e) {
      throw Left(FirebaseException(plugin: 'Firestore', message: e.message));
    }
  }

  @override
  Future<Either<FirebaseException, List<Task>>> getAllTasks() async {
    try {
      final response = await dataSource.getAll();
      final tasks = response.map((task) => task.toEntity()).toList();

      return Right(tasks);
    } on FirebaseException catch (e) {
      throw Left(FirebaseException(plugin: 'Firestore', message: e.message));
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await dataSource.update(taskModel);
      return Right(unit);
    } on FirebaseException catch (e) {
      throw Left(FirebaseException(plugin: 'Firestore', message: e.message));
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> removeTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      await dataSource.remove(taskModel);
      return Right(unit);
    } on FirebaseException catch (e) {
      throw Left(FirebaseException(plugin: 'Firestore', message: e.message));
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> removeMultipleTasks(
    List<Task> tasks,
  ) async {
    try {
      final tasksModel = tasks
          .map((task) => TaskModel.fromEntity(task))
          .toList();
      await dataSource.removeMultipleTasks(tasksModel);
      return Right(unit);
    } on FirebaseException catch (e) {
      throw Left(FirebaseException(plugin: 'Firestore', message: e.message));
    }
  }
}
