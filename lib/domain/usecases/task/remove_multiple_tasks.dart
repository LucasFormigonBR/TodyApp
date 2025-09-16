import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todyapp/domain/repositories/task_repository.dart';

import '../../entities/task.dart';

class RemoveMultipleTasks {
  final TaskRepository _repository;

  RemoveMultipleTasks(this._repository);

  Future<Either<FirebaseException, Unit>> call(List<Task> tasks) async {
    return await _repository.removeMultipleTasks(tasks);
  }
}
