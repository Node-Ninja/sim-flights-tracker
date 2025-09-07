import 'package:flutter/material.dart';

import '../utils.dart';

class NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    if (route.settings.arguments != null) {
      var arguments = route.settings.arguments as Map;

      await logScreenView(
          route.settings.name ?? arguments['name'] ?? 'Unknown Screen',
          '${route.settings.name ?? arguments['name'] ?? 'Unknown'}.class'
      );
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) async {
    await logScreenView(newRoute?.settings.name ?? 'Unknown Screen', '${newRoute?.settings.name ?? 'Unknown'}.class');
  }
}