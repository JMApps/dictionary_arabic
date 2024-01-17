import 'package:arabic/core/routes/route_names.dart';
import 'package:arabic/presentation/uiModules/ios/pages/all_collections_page.dart';
import 'package:flutter/cupertino.dart';

class CupertinoRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.allCollectionsPage:
        return CupertinoPageRoute(
          builder: (_) => const AllCollectionsPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
