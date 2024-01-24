import 'package:flutter/cupertino.dart';

import '../../domain/entities/args/collection_args.dart';
import '../../domain/entities/args/word_args.dart';
import '../../presentation/uiModules/ios/pages/all_collections_page.dart';
import '../../presentation/uiModules/ios/pages/collection_detail_page.dart';
import '../../presentation/uiModules/ios/pages/word_detail_page.dart';
import 'route_names.dart';

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
      case RouteNames.wordDetailPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return CupertinoPageRoute(
          builder: (_) => WordDetailPage(wordId: wordArgs.wordId),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
