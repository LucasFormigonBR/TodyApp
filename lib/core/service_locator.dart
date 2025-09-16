import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';
import 'package:todyapp/core/configs/app_config.dart';
import 'package:todyapp/data/repositories/task_repository_impl.dart';
import 'package:todyapp/domain/repositories/task_repository.dart';
import 'package:todyapp/domain/usecases/authenticate_with_github.dart';
import 'package:todyapp/domain/usecases/task/get_all_tasks.dart';
import 'package:todyapp/domain/usecases/task/add_task.dart';
import 'package:todyapp/domain/usecases/remove_task.dart';

import '../data/datasources/firebase_auth_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/authenticate_with_google.dart';
import '../domain/usecases/task/remove_multiple_tasks.dart';
import '../domain/usecases/send_ink_to_email.dart';
import '../domain/usecases/task/update_task.dart';
import '../presentation/login/cubit/email_cubit.dart';
import '../presentation/login/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // App Configs
  sl.registerLazySingleton<AppConfig>(() => AppConfig());

  // Google Authentication
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  // Data sources
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSource(sl()),
  );

  //Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  // Use cases
  sl.registerLazySingleton<SendLinkToEmail>(() => SendLinkToEmail(sl()));
  sl.registerLazySingleton<AuthenticateWithGoogle>(
    () => AuthenticateWithGoogle(sl()),
  );
  sl.registerLazySingleton<AuthenticateWithGithub>(
    () => AuthenticateWithGithub(sl()),
  );
  sl.registerLazySingleton<AddTask>(() => AddTask(sl()));
  sl.registerLazySingleton<GetAllTasks>(() => GetAllTasks(sl()));
  sl.registerLazySingleton<UpdateTask>(() => UpdateTask(sl()));
  sl.registerLazySingleton<RemoveTask>(() => RemoveTask(sl()));
  sl.registerLazySingleton<RemoveMultipleTasks>(
    () => RemoveMultipleTasks(sl()),
  );

  // Cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<EmailCubit>(() => EmailCubit(sl()));
  sl.registerFactory<TaskCubit>(() => TaskCubit(sl(), sl(), sl(), sl()));
}
