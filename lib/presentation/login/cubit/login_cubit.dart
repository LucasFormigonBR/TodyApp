import 'package:bloc/bloc.dart';
import 'package:todyapp/domain/usecases/send_ink_to_email.dart';
import 'package:todyapp/presentation/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SendLinkToEmail sendToEmail;
  LoginCubit(this.sendToEmail) : super(LoginInitial());

  void sendLinkEmail(String email) async {
    try {
      emit(LoginLoading());
      sendToEmail(email);

      await Future.delayed(Duration(seconds: 2));
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
