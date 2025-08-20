import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';

void validateInitialRoute() {
  final prefs = sl<SharedPreferences>();
  final isUserAuthenticated = prefs.getBool('authenticated') ?? false;

  if (isUserAuthenticated) {
    prefs.setString('initial_route', '/details-todyapp');
    return;
  }
  prefs.setString('initial_route', '/');
}
