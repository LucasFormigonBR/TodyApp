// lib/app/router.dart
import 'package:go_router/go_router.dart';
import 'package:todyapp/features/apresentation/presentation/pages/apresentation_structure_page.dart';
import 'package:todyapp/features/home/presentation/pages/choose_theme_page.dart';
import 'package:todyapp/features/login/presentation/pages/create_account_page.dart';
import 'package:todyapp/features/login/presentation/pages/login_email_page.dart';
import 'package:todyapp/features/login/presentation/pages/login_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ApresentationStructurePage(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/login-email',
      builder: (context, state) => const LoginEmailPage(),
    ),
    GoRoute(
      path: '/create-account',
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: '/choose-theme',
      builder: (context, state) => const ChooseThemePage(),
    ),
  ],
);
