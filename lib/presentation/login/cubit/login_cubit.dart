import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/presentation/login/cubit/login_state.dart';

import '../../../core/service_locator.dart';
import '../../../domain/usecases/authenticate_with_google.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticateWithGoogle _initializeAuthenticateWithGoogle;
  LoginCubit(this._initializeAuthenticateWithGoogle) : super(LoginInitial());

  final prefs = sl<SharedPreferences>();

  Future<void> authenticateWithGoogle() async {
    try {
      emit(LoginLoading());
      await _initializeAuthenticateWithGoogle();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
