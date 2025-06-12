// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todyapp/core/constants/styles_app.dart';
import 'package:todyapp/core/routes/router.dart';
import 'package:todyapp/features/apresentation/presentation/cubit/apresentation_cubit.dart';

class TodyApp extends StatelessWidget {
  const TodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ApresentationCubit())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Todyapp',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: GoogleFonts.barlow().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontWeight: FontWeight.bold),
            labelLarge: TextStyle(color: Color(0xFF767E8C)),
            labelMedium: TextStyle(color: Color(0xFF767E8C)),
            labelSmall: TextStyle(color: Color(0xFF767E8C)),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF6F7F9),
            hintStyle: TextStyle(
              color: Color(0xFFA9B0C5),
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: StylesApp.grayText,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
              backgroundColor: Colors.teal,
              disabledBackgroundColor: const Color(0xFFCBF1F0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
