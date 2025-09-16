import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  void saveSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    emit(UpdateSelectedDate());
  }
}
