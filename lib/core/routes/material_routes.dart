import 'package:flutter/material.dart';

import '../../domain/entities/args/collection_args.dart';
import '../../domain/entities/args/word_args.dart';
import '../../domain/entities/args/word_favorite_collection_args.dart';
import '../../domain/entities/args/word_move_args.dart';
import '../../presentation/uiModules/android/cards/card_mode_page.dart';
import '../../presentation/uiModules/android/cards/cards_mode_detail_page.dart';
import '../../presentation/uiModules/android/cards/swipe/card_swipe_mode_page.dart';
import '../../presentation/uiModules/android/cards/swipe/cards_swipe_mode_detail_page.dart';
import '../../presentation/uiModules/android/collections/all_collections_page.dart';
import '../../presentation/uiModules/android/constructor/word_constructor_detail_page.dart';
import '../../presentation/uiModules/android/constructor/word_constructor_page.dart';
import '../../presentation/uiModules/android/favorites/collection_detail_page.dart';
import '../../presentation/uiModules/android/favorites/add_favorite_word_page.dart';
import '../../presentation/uiModules/android/favorites/favorite_word_detail_page.dart';
import '../../presentation/uiModules/android/favorites/favorite_word_select_collection.dart';
import '../../presentation/uiModules/android/favorites/move_favorite_word_page.dart';
import '../../presentation/uiModules/android/quiz/quiz_detail_page.dart';
import '../../presentation/uiModules/android/quiz/quiz_page.dart';
import '../../presentation/uiModules/android/search/search_words_page.dart';
import '../../presentation/uiModules/android/search/word_detail_page.dart';
import '../../presentation/uiModules/android/settings/app_settings_page.dart';
import 'route_names.dart';

class MaterialRoutes {
  static Route onGeneratorRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.appSettingsPage:
        return MaterialPageRoute(
          builder: (_) => const AppSettingsPage(),
        );
      case RouteNames.searchWordsPage:
        return MaterialPageRoute(
          builder: (_) => const SearchWordsPage(),
        );
      case RouteNames.wordDetailPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return MaterialPageRoute(
          builder: (_) => WordDetailPage(wordNumber: wordArgs.wordNumber),
        );
      case RouteNames.addFavoriteWordPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return MaterialPageRoute(
          builder: (_) => AddFavoriteWordPage(wordNumber: wordArgs.wordNumber),
        );
      case RouteNames.favoriteWordSelectionCollectionPage:
        final WordFavoriteCollectionArgs favoriteCollectionArgs = routeSettings.arguments as WordFavoriteCollectionArgs;
        return MaterialPageRoute(
          builder: (_) => FavoriteWordSelectCollection(
            wordModel: favoriteCollectionArgs.wordModel,
            serializableIndex: favoriteCollectionArgs.serializableIndex,
          ),
        );
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
      case RouteNames.wordFavoriteDetailPage:
        final WordArgs wordArgs = routeSettings.arguments as WordArgs;
        return MaterialPageRoute(
          builder: (_) => FavoriteWordDetailPage(
            wordNumber: wordArgs.wordNumber,
          ),
        );
      case RouteNames.moveFavoriteWordPage:
        final WordMoveArgs wordMoveArgs = routeSettings.arguments as WordMoveArgs;
        return MaterialPageRoute(
          builder: (_) => MoveFavoriteWordPage(
            wordNumber: wordMoveArgs.wordNumber,
            oldCollectionId: wordMoveArgs.oldCollectionId,
          ),
        );
      case RouteNames.cardModePage:
        return MaterialPageRoute(
          builder: (_) => const CardModePage(),
        );
      case RouteNames.cardSwipeModePage:
        return MaterialPageRoute(
          builder: (_) => const CardSwipeModePage(),
        );
      case RouteNames.cardsModeDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return MaterialPageRoute(
          builder: (_) => CardsModeDetailPage(collectionModel: collectionArgs.collectionModel),
        );
      case RouteNames.cardsSwipeModeDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return MaterialPageRoute(
          builder: (_) => CardsSwipeModeDetailPage(collectionModel: collectionArgs.collectionModel),
        );
      case RouteNames.wordConstructorPage:
        return MaterialPageRoute(
          builder: (_) => const WordConstructorPage(),
        );
      case RouteNames.wordConstructorDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return MaterialPageRoute(
          builder: (_) => WordConstructorDetailPage(collectionModel: collectionArgs.collectionModel),
        );
      case RouteNames.quizPage:
        return MaterialPageRoute(
          builder: (_) => const QuizPage(),
        );
      case RouteNames.quizDetailPage:
        final CollectionArgs collectionArgs = routeSettings.arguments as CollectionArgs;
        return MaterialPageRoute(
          builder: (_) => QuizDetailPage(collectionModel: collectionArgs.collectionModel),
        );
      default:
        throw Exception('Invalid route ${routeSettings.name}');
    }
  }
}
