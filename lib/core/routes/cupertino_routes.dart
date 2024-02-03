import 'package:arabic/domain/entities/args/word_favorite_collection_args.dart';
import 'package:arabic/presentation/uiModules/ios/favorites/favorite_word_detail_page.dart';
import 'package:arabic/presentation/uiModules/ios/favorites/favorite_word_select_collection.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/args/collection_args.dart';
import '../../domain/entities/args/word_args.dart';
import '../../presentation/uiModules/ios/favorites/add_favorite_word_page.dart';
import '../../presentation/uiModules/ios/collections/all_collections_page.dart';
import '../../presentation/uiModules/ios/collections/collection_detail_page.dart';
import '../../presentation/uiModules/ios/search/search_words_page.dart';
import '../../presentation/uiModules/ios/search/word_detail_page.dart';
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
      case RouteNames.wordFavoriteCollectionPage:
        final WordFavoriteCollectionArgs favoriteCollectionArgs = routeSettings.arguments as WordFavoriteCollectionArgs;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => FavoriteWordSelectCollection(wordModel: favoriteCollectionArgs.wordModel, serializableIndex: favoriteCollectionArgs.serializableIndex),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      case RouteNames.wordFavoriteDetailPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return CupertinoPageRoute(
          builder: (_) => FavoriteWordDetailPage(favoriteWordId: wordArgs.wordId),
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
