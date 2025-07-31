import 'package:equatable/equatable.dart';

import '../../presentation/home/ui_models/ui_priority.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String hours;
  final UiPriority priority;

  const Task({
    this.id,
    this.title = "",
    this.description = "",
    this.date = "",
    this.hours = "",
    this.priority = UiPriority.none,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    String? hours,
    UiPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, hours, priority];
}
