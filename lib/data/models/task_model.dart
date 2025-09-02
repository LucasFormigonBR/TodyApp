import 'package:todyapp/domain/entities/task.dart';

import '../../presentation/home/ui_models/ui_priority.dart';

class TaskModel {
  final String? id;
  final String title;
  final String description;
  final String date;
  final String hours;
  final UiPriority priority;

  const TaskModel({
    this.id,
    this.title = "",
    this.description = "",
    this.date = "",
    this.hours = "",
    this.priority = UiPriority.none,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? hours,
    UiPriority? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'title': title,
      'description': description,
      'date': date,
      'hours': hours,
      'priority': priority.index,
    };
    return map;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return TaskModel(
      id: id,
      title: map['title'] as String? ?? "",
      description: map['description'] as String? ?? "",
      date: map['date'] as String? ?? "",
      hours: map['hours'] as String? ?? "",
      priority: UiPriority.values[map['priority'] as int? ?? 0],
    );
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      hours: task.hours,
      priority: task.priority,
    );
  }

  Task toEntity() => Task(
    id: id,
    title: title,
    description: description,
    date: date,
    hours: hours,
    priority: priority,
  );
}
