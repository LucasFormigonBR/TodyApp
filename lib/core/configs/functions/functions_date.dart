import 'package:intl/intl.dart';

String nameMonthAndYear(DateTime date) {
  final month = nameMonth(date.month);
  final year = date.year.toString();

  return "$month $year";
}

String nameMonth(int month) {
  switch (month) {
    case 1:
      return "Janeiro";
    case 2:
      return "Fevereiro";
    case 3:
      return "Março";
    case 4:
      return "Abril";
    case 5:
      return "Maio";
    case 6:
      return "Junho";
    case 7:
      return "Julho";
    case 8:
      return "Agosto";
    case 9:
      return "Setembro";
    case 10:
      return "Outubro";
    case 11:
      return "Novembro";
    case 12:
      return "Dezembro";
    default:
      return "Mês inválido";
  }
}

int daysInMonth({required int year, required int month}) {
  var lastDayOfMonth = DateTime(year, month + 1, 0);
  return lastDayOfMonth.day;
}

List<String> weekDaysName() => [
  "Seg",
  "Ter",
  "Qua",
  "Qui",
  "Sex",
  "Sab",
  "Dom",
];

String formatDate(DateTime date) {
  final dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(date);
}

DateTime formatForDateTime({
  required int day,
  required int month,
  required int year,
}) {
  final dayFormatted = day.toString().padLeft(2, '0');
  final monthFormatted = month.toString().padLeft(2, '0');

  final dateFormatted = "$year-$monthFormatted-$dayFormatted";
  final dateTime = DateTime.parse(dateFormatted);
  return dateTime;
}
