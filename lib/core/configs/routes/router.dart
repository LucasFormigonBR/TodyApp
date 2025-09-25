import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todyapp/core/service_locator.dart';
import 'package:todyapp/presentation/home/pages/account_page.dart';
import 'package:todyapp/presentation/home/pages/details_todyapp_page.dart';
import 'package:todyapp/presentation/home/pages/current_page.dart';
import 'package:todyapp/presentation/home/pages/inbox_page.dart';
import 'package:todyapp/presentation/home/pages/profile_page.dart';
import 'package:todyapp/presentation/login/pages/create_account_page.dart';
import 'package:todyapp/presentation/login/pages/login_email_page.dart';
import 'package:todyapp/presentation/login/pages/login_page.dart';

import '../../../presentation/apresentation/pages/apresentation_structure_page.dart';
import '../firebase/firebase_auth_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final prefs = sl<SharedPreferences>();
final firebaseAuth = sl<FirebaseAuth>();

final initialRoute = prefs.getString('initial_route') ?? "/";
final userAuthenticated = prefs.getBool('authenticated') ?? false;
final currentRoute = prefs.getString('current_route') ?? "";

final goRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: initialRoute,
  redirect: (BuildContext context, GoRouterState state) async {
    final uri = state.uri;
    final firebaseAuthApp = FirebaseAuthApp();

    bool isAuthenticationURI = firebaseAuthApp.isAuthenticationURI(uri);

    if (isAuthenticationURI) {
      if (userAuthenticated) {
        return currentRoute;
      }

      bool successfulAuthentication = await firebaseAuthApp
          .validateAuthenticationEmailLink(uri);

      if (successfulAuthentication) {
        prefs.setString('initial_route', '/details-todyapp');
        return '/details-todyapp?message=Autenticação realizada com sucesso.';
      }
      prefs.setString('initial_route', '/');
      return '$currentRoute?message=Link inválido ou expirado.';
    }
    prefs.setString('current_route', state.fullPath ?? "");
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final message = state.uri.queryParameters['message'] ?? '';
        return ApresentationStructurePage(
          key: ValueKey(message),
          message: message,
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final message = state.uri.queryParameters['message'] ?? '';
        return LoginPage(key: ValueKey(message), message: message);
      },
    ),
    GoRoute(
      path: '/login-email',
      builder: (context, state) {
        final message = state.uri.queryParameters['message'] ?? '';
        return LoginEmailPage(key: ValueKey(message), message: message);
      },
    ),
    GoRoute(
      path: '/create-account',
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: '/details-todyapp',
      builder: (context, state) {
        final message = state.uri.queryParameters['message'] ?? '';
        return DetailsTodyAppPage(key: ValueKey(message), message: message);
      },
    ),
    GoRoute(path: '/inbox', builder: (context, state) => InboxPage()),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final message = state.uri.queryParameters['message'] ?? '';
        return CurrentPage(key: ValueKey(message), message: message);
      },
    ),
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
    GoRoute(path: '/account', builder: (context, state) => AccountPage()),
  ],
);
