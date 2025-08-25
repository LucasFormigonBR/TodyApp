import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/domain/usecases/authenticate_with_github.dart';

import '../data/datasources/firebase_auth_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/authenticate_with_google.dart';
import '../domain/usecases/send_ink_to_email.dart';
import '../presentation/login/cubit/email_cubit.dart';
import '../presentation/login/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Google Authentication
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  // Data sources
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(sl()),
  );

  //Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<SendLinkToEmail>(() => SendLinkToEmail(sl()));
  sl.registerLazySingleton<AuthenticateWithGoogle>(
    () => AuthenticateWithGoogle(sl()),
  );
  sl.registerLazySingleton<AuthenticateWithGithub>(
    () => AuthenticateWithGithub(sl()),
  );

  // Cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<EmailCubit>(() => EmailCubit(sl()));
}
