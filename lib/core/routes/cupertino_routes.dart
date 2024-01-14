import 'package:flutter/cupertino.dart';

import '../../presentation/uiModules/ios/pages/main_page.dart';

class CupertinoRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => const MainPage(),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
