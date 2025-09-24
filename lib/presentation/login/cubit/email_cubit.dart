import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../domain/usecases/login/send_ink_to_email.dart';
import 'email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  final SendLinkToEmail sendToEmail;
  EmailCubit(this.sendToEmail) : super(EmailInitial());

  Timer? _cooldownTimer;

  void sendLinkEmail(String email) async {
    try {
      int totalTime = 5;
      await sendToEmail(email);
      emit(EmailSend());
      emit(EmailTimer(totalTime));

      _cooldownTimer?.cancel();

      _cooldownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        totalTime--;
        if (totalTime <= 0) {
          timer.cancel();
          emit(EmailInitial());
          return;
        }
        emit(EmailTimer(totalTime));
        return;
      });
    } catch (error) {
      emit(EmailError(error.toString()));
    }
  }
}
