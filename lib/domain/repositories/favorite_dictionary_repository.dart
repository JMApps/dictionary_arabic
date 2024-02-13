import '../entities/favorite_dictionary_entity.dart';

abstract class FavoriteDictionaryRepository {
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords();

  Future<bool> isWordFavorite({required int wordId});

  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId});

  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId});

  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByQuiz({required int favoriteWordNr, required String wordRoot});

  Future<void> addFavoriteWord({required FavoriteDictionaryEntity model});

  Future<void> changeFavoriteWord({required int wordId, required int serializableIndex});

  Future<void> moveFavoriteWord({required int wordNr, required int oldCollectionId, required int collectionId});

  Future<void> deleteFavoriteWord({required int favoriteWordId, required int collectionId});
}
