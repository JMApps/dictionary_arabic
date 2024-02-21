import 'package:flutter/material.dart';

import '../../domain/entities/args/collection_args.dart';
import '../../presentation/uiModules/android/collections/all_collections_page.dart';
import '../../presentation/uiModules/android/collections/collection_detail_page.dart';
import 'route_names.dart';

class MaterialRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.allCollectionsPage:
        return MaterialPageRoute(
          builder: (_) => const AllCollectionsPage(),
        );
      case RouteNames.collectionDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return MaterialPageRoute(
          builder: (_) => CollectionDetailPage(
            collectionModel: collectionArgs.collectionModel,
          ),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
