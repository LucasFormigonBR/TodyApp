import 'package:flutter_bloc/flutter_bloc.dart';

import 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void updateToggleButtonSend(bool isEnabled) {
    if (isEnabled) {
      emit(ButtonToggleSendTask(isEnabled));
      return;
    }

    emit(ButtonToggleSendTask(isEnabled));
  }

  void updateToggleButtonDeleteTasks(bool isEnabled) =>
      emit(ButtonToggleDeleteTasks(isEnabled));
}
