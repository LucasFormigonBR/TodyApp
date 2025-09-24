import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/data/models/task_model.dart';

import '../../core/service_locator.dart';

class TaskDataSource {
  final _db = sl<FirebaseFirestore>();
  final authenticatedUser = sl<AppConfig>();

  Future<String> add(TaskModel task) async {
    try {
      final doc = await _db
          .collection('users')
          .doc(authenticatedUser.uid)
          .collection('tasks')
          .add(task.toJson());

      return doc.id;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<List<TaskModel>> getAll() async {
    try {
      final querySnapshots = await _db
          .collection('users')
          .doc(authenticatedUser.uid)
          .collection('tasks')
          .get();

      final tasks = querySnapshots.docs.map((doc) {
        return TaskModel.fromMap(doc.data(), id: doc.id);
      }).toList();

      return tasks;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> update(TaskModel task) async {
    try {
      await _db
          .collection('users')
          .doc(authenticatedUser.uid)
          .collection('tasks')
          .doc(task.id)
          .update(task.toJson());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> remove(TaskModel task) async {
    try {
      await _db
          .collection('users')
          .doc(authenticatedUser.uid)
          .collection('tasks')
          .doc(task.id)
          .delete();
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> removeMultipleTasks(List<TaskModel> tasks) async {
    try {
      final batch = _db.batch();

      for (final task in tasks) {
        final docRef = _db
            .collection('users')
            .doc(authenticatedUser.uid)
            .collection('tasks')
            .doc(task.id);

        batch.delete(docRef);
      }

      await batch.commit();
    } on FirebaseException {
      rethrow;
    }
  }
}
