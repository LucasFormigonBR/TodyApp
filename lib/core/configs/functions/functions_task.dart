import '../../../domain/entities/task.dart';
import 'functions_date.dart';

List<Task> filterTasksByToday({required List<Task> tasks}) {
  final todayDate = DateTime.now();
  final selectedDate = formatDate(todayDate);
  final tasksFiltered = tasks.where((t) => t.date == selectedDate).toList();

  return tasksFiltered;
}

List<Task> filterTasksByDate({
  required List<Task> tasks,
  required DateTime date,
}) {
  final selectedDate = formatDate(date);
  final tasksFiltered = tasks.where((t) => t.date == selectedDate).toList();

  return tasksFiltered;
}
