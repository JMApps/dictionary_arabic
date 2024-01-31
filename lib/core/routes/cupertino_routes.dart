import 'package:flutter/cupertino.dart';

import '../../domain/entities/args/collection_args.dart';
import '../../domain/entities/args/word_args.dart';
import '../../presentation/uiModules/ios/pages/add_favorite_word_page.dart';
import '../../presentation/uiModules/ios/pages/all_collections_page.dart';
import '../../presentation/uiModules/ios/pages/collection_detail_page.dart';
import '../../presentation/uiModules/ios/pages/search_words_page.dart';
import '../../presentation/uiModules/ios/pages/word_detail_page.dart';
import 'route_names.dart';

class CupertinoRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.searchWordsPage:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SearchWordsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      case RouteNames.addFavoriteWordPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => AddFavoriteWordPage(wordId: wordArgs.wordId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      case RouteNames.allCollectionsPage:
        return CupertinoPageRoute(
          builder: (_) => const AllCollectionsPage(),
        );
      case RouteNames.collectionDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return CupertinoPageRoute(
          builder: (_) => CollectionDetailPage(
              collectionModel: collectionArgs.collectionEntity),
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
