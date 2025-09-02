import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todyapp/domain/repositories/task_repository.dart';

import '../entities/task.dart';

class GetAllTasks {
  final TaskRepository _repository;

  GetAllTasks(this._repository);

  Future<Either<FirebaseException, List<Task>>> call() async =>
      _repository.getAllTasks();
}
