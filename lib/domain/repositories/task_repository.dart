import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart' hide Task;

import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<FirebaseException, String>> addTask(Task task);
  Future<Either<FirebaseException, List<Task>>> getAllTasks();
  Future<Either<FirebaseException, Unit>> updateTask(Task task);
  Future<Either<FirebaseException, Unit>> removeTask(Task task);
  Future<Either<FirebaseException, Unit>> removeMultipleTasks(List<Task> tasks);
}
