import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/domain/usecases/login/sign_out.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SignOut _signOut;
  ProfileCubit(this._signOut) : super(ProfileInitialState());

  Future<void> logOut() async {
    emit(ProfileLoadingState());
    final result = await _signOut();

    result.fold(
      (exception) {
        emit(
          ProfileErrorState(
            exception.message ?? "Houve um erro desconhecido: $exception",
          ),
        );
      },
      (success) {
        emit(ProfileLogoutState());
      },
    );
  }
}
