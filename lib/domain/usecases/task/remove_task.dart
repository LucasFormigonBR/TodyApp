import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart' hide Task;

import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class RemoveTask {
  final TaskRepository _repository;

  RemoveTask(this._repository);

  Future<Either<FirebaseException, Unit>> call(Task task) async =>
      await _repository.removeTask(task);
}
