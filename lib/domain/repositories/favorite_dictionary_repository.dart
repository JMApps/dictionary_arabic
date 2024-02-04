import '../entities/favorite_dictionary_entity.dart';

abstract class FavoriteDictionaryRepository {
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords();

  Future<bool> isWordFavorite({required int wordId});

  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId});

  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId});

  Future<int> addFavoriteWord({required FavoriteDictionaryEntity model});

  Future<int> changeFavoriteWord({required int wordId, required int serializableIndex});

  Future<void> moveFavoriteWord({required int wordNr, required int collectionId});

  Future<int> deleteFavoriteWord({required int favoriteWordId});
}
