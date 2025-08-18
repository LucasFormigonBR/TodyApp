abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailSend extends EmailState {}

class EmailTimer extends EmailState {
  final int secondsRemaining;

  EmailTimer(this.secondsRemaining);
}

class EmailFinished extends EmailState {}

class EmailError extends EmailState {
  final String message;

  EmailError(this.message);
}
