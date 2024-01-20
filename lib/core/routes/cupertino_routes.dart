import 'package:arabic/core/routes/route_names.dart';
import 'package:arabic/domain/entities/args/collection_args.dart';
import 'package:arabic/presentation/uiModules/ios/pages/all_collections_page.dart';
import 'package:arabic/presentation/uiModules/ios/pages/collection_detail_page.dart';
import 'package:flutter/cupertino.dart';

class CupertinoRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.allCollectionsPage:
        return CupertinoPageRoute(
          builder: (_) => const AllCollectionsPage(),
        );
      case RouteNames.collectionDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return CupertinoPageRoute(
          builder: (_) => CollectionDetailPage(collectionModel: collectionArgs.collectionEntity),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
