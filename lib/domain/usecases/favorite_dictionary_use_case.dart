
import '../entities/change_favorite_dictionary_entity.dart';
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

  Future<int> fetchAddFavoriteWord({required FavoriteDictionaryEntity model}) async {
    try {
      final int addFavoriteWord = await _favoriteDictionaryRepository.addFavoriteWord(model: model);
      return addFavoriteWord;
    } catch (e) {
      throw Exception('Add favorite word data error: $e');
    }
  }

  Future<int> fetchChangeFavoriteWord({required ChangeFavoriteDictionaryEntity model}) async {
    try {
      final int changeFavoriteWord = await _favoriteDictionaryRepository.changeFavoriteWord(model: model);
      return changeFavoriteWord;
    } catch (e) {
      throw Exception('Change favorite word data error: $e');
    }
  }

  Future<int> fetchDeleteFavoriteWord({required int favoriteWordId}) async {
    try {
      final int deleteFavoriteWord = await _favoriteDictionaryRepository.deleteFavoriteWord(favoriteWordId: favoriteWordId);
      return deleteFavoriteWord;
    } catch (e) {
      throw Exception('Delete favorite word data error: $e');
    }
  }
}
