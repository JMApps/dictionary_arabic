import 'package:flutter/material.dart';

import '../../presentation/uiModules/android/collections/all_collections_page.dart';
import 'route_names.dart';

class MaterialRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.allCollectionsPage:
        return MaterialPageRoute(
          builder: (_) => const AllCollectionsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
