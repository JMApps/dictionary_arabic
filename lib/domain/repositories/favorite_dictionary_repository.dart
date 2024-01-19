import '../entities/favorite_dictionary_entity.dart';

abstract class DefaultDictionaryRepository {
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords();

  Future<List<FavoriteDictionaryEntity>> getCollectionFavoriteWords({required int collectionId});

  Future<List<FavoriteDictionaryEntity>> searchFavoriteWords({required String arabic, required String translation});

  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int wordId});

  Future<int> addFavoriteWord({required FavoriteDictionaryEntity model});

  Future<int> changeFavoriteWord({required FavoriteDictionaryEntity model});

  Future<int> deleteFavoriteWord({required int favoriteWordId});
}
