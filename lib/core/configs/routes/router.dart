import 'package:go_router/go_router.dart';
import 'package:todyapp/presentation/home/pages/details_todyapp_page.dart';
import 'package:todyapp/presentation/home/pages/current_page.dart';
import 'package:todyapp/presentation/home/pages/inbox_page.dart';
import 'package:todyapp/presentation/login/pages/create_account_page.dart';
import 'package:todyapp/presentation/login/pages/login_email_page.dart';
import 'package:todyapp/presentation/login/pages/login_page.dart';

import '../../../presentation/apresentation/pages/apresentation_structure_page.dart';

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
      path: '/details-todyapp',
      builder: (context, state) => const DetailsTodyAppPage(),
    ),
    GoRoute(path: '/inbox', builder: (context, state) => const InboxPage()),
    GoRoute(path: '/home', builder: (context, state) => CurrentPage()),
  ],
);
