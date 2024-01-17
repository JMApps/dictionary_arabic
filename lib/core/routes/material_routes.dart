import 'package:arabic/presentation/uiModules/android/pages/main_material_page.dart';
import 'package:flutter/material.dart';

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
