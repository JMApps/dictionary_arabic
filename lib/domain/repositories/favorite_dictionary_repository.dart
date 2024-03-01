import '../entities/favorite_dictionary_entity.dart';

abstract class FavoriteDictionaryRepository {
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords();

  Future<bool> isWordFavorite({required int wordNumber});

  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId});

  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId});

  Future<void> addFavoriteWord({required FavoriteDictionaryEntity model});

  Future<void> changeFavoriteWord({required int wordNumber, required int serializableIndex});

  Future<void> moveFavoriteWord({required int wordNumber, required int oldCollectionId, required int collectionId});

  Future<void> deleteFavoriteWord({required int favoriteWordId});
}
