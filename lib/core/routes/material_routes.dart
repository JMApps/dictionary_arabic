import 'package:flutter/material.dart';

import '../../presentation/uiModules/android/main/main_material_page.dart';

class MaterialRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainMaterialPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
