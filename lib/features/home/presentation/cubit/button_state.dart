abstract class ButtonState {}

class ButtonInitial extends ButtonState {}

class ButtonToggleSendTask extends ButtonState {
  bool isActive;

  ButtonToggleSendTask(this.isActive);
}

class ButtonToggleDeleteTasks extends ButtonState {
  bool isActive;

  ButtonToggleDeleteTasks(this.isActive);
}
