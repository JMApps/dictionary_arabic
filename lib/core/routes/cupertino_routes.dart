import 'package:arabic/presentation/uiModules/ios/pages/main_cupertino_page.dart';
import 'package:flutter/cupertino.dart';

class CupertinoRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => const MainCupertinoPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
