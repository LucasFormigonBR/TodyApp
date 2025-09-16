import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart' hide Task;

import '../../entities/task.dart';
import '../../repositories/task_repository.dart';

class AddTask {
  final TaskRepository _taskRepository;

  AddTask(this._taskRepository);

  Future<Either<FirebaseException, String>> call(Task task) async =>
      _taskRepository.addTask(task);
}
