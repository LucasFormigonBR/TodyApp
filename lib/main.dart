import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todyapp/features/apresentation/presentation/cubit/apresentation_cubit.dart';
import 'package:todyapp/features/apresentation/presentation/pages/apresentation_structure_page.dart';
import 'package:todyapp/firebase_options.dart';

void initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() {
  initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApresentationCubit>(
          create: (context) => ApresentationCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Todyapp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.barlow(
            textStyle: const TextStyle(letterSpacing: 0.5),
          ).fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              disabledBackgroundColor: Color(0xFFCBF1F0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => ApresentationStructurePage(),
            ),
            // GoRoute(
            //   path: '/login',
            //   builder: (context, state) => const LoginPage(),
            // ),
          ],
        ),
      ),
    );
  }
}
