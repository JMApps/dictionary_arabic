import '../entities/change_favorite_dictionary_entity.dart';
import '../entities/favorite_dictionary_entity.dart';

abstract class FavoriteDictionaryRepository {
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords();

  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId});

  Future<List<FavoriteDictionaryEntity>> searchFavoriteWords({required String searchQuery});

  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId});

  Future<int> addFavoriteWord({required FavoriteDictionaryEntity model});

  Future<int> changeFavoriteWord({required ChangeFavoriteDictionaryEntity model});

  Future<int> deleteFavoriteWord({required int favoriteWordId});
}
