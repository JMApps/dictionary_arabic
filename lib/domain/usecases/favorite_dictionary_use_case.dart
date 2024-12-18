
import '../entities/favorite_dictionary_entity.dart';
import '../repositories/favorite_dictionary_repository.dart';

class FavoriteDictionaryUseCase {
  final FavoriteDictionaryRepository _favoriteDictionaryRepository;

  FavoriteDictionaryUseCase(this._favoriteDictionaryRepository);

  Future<List<FavoriteDictionaryEntity>> fetchAllFavoriteWords() async {
    try {
      final List<FavoriteDictionaryEntity> allFavoriteWords = await _favoriteDictionaryRepository.getAllFavoriteWords();
      return allFavoriteWords;
    } catch (e) {
      throw Exception('Get all favorite words data error: $e');
    }
  }

  Future<bool> fetchIsWordFavorite({required int wordId}) async {
    try {
      final bool isFavorite = await _favoriteDictionaryRepository.isWordFavorite(wordNumber: wordId);
      return isFavorite;
    } catch (e) {
      throw Exception('Get check favorite word data error: $e');
    }
  }

  Future<List<FavoriteDictionaryEntity>> fetchFavoriteWordsByCollectionId({required int collectionId}) async {
    try {
      final List<FavoriteDictionaryEntity> collectionFavoriteWords = await _favoriteDictionaryRepository.getFavoriteWordsByCollectionId(collectionId: collectionId);
      return collectionFavoriteWords;
    } catch (e) {
      throw Exception('Get collection favorite words data error: $e');
    }
  }

  Future<FavoriteDictionaryEntity> fetchFavoriteWordById({required int favoriteWordId}) async {
    try {
      final FavoriteDictionaryEntity favoriteWordById = await _favoriteDictionaryRepository.getFavoriteWordById(favoriteWordId: favoriteWordId);
      return favoriteWordById;
    } catch (e) {
      throw Exception('Get favorite word by id data error: $e');
    }
  }

  Future<void> fetchAddFavoriteWord({required FavoriteDictionaryEntity model}) async {
    try {
      await _favoriteDictionaryRepository.addFavoriteWord(model: model);
    } catch (e) {
      throw Exception('Add favorite word data error: $e');
    }
  }

  Future<void> fetchChangeFavoriteWord({required int wordId, required int serializableIndex}) async {
    try {
      await _favoriteDictionaryRepository.changeFavoriteWord(wordNumber: wordId, serializableIndex: serializableIndex);
    } catch (e) {
      throw Exception('Change favorite word data error: $e');
    }
  }

  Future<void> fetchMoveFavoriteWord({required int wordNr, required int oldCollectionId, required int collectionId}) async {
    try {
      await _favoriteDictionaryRepository.moveFavoriteWord(wordNumber: wordNr, oldCollectionId: oldCollectionId, collectionId: collectionId);
    } catch (e) {
      throw Exception('Move favorite word data error: $e');
    }
  }

  Future<void> fetchDeleteFavoriteWord({required int favoriteWordId}) async {
    try {
      await _favoriteDictionaryRepository.deleteFavoriteWord(favoriteWordId: favoriteWordId);
    } catch (e) {
      throw Exception('Delete favorite word data error: $e');
    }
  }
}
