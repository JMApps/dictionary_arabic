import 'package:flutter/material.dart';

import '../../presentation/uiModules/android/pages/main_page.dart';

class MaterialRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
