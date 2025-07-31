import 'package:bloc/bloc.dart';
import 'package:todyapp/presentation/home/cubit/mode_checkbox_state.dart';

class ModeCheckboxCubit extends Cubit<ModeCheckboxState> {
  ModeCheckboxCubit() : super(ModeCheckboxUpdate(false));

  bool _checkboxMode = false;

  void updateCheckboxMode() =>
      emit(ModeCheckboxUpdate(_checkboxMode = !_checkboxMode));
}
