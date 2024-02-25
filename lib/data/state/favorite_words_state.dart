import 'package:flutter/cupertino.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';
import '../../domain/usecases/favorite_dictionary_use_case.dart';
import '../repositories/favorite_dictionary_data_repository.dart';

class FavoriteWordsState extends ChangeNotifier {
  final FavoriteDictionaryUseCase _useCase = FavoriteDictionaryUseCase(FavoriteDictionaryDataRepository());

  Future<List<FavoriteDictionaryEntity>> fetchAllFavoriteWords() async {
    return await _useCase.fetchAllFavoriteWords();
  }

  Future<bool> fetchIsWordFavorite({required int wordNumber}) async {
    return await _useCase.fetchIsWordFavorite(wordId: wordNumber);
  }

  Future<List<FavoriteDictionaryEntity>> fetchFavoriteWordsByCollectionId({required int collectionId}) async {
    return await _useCase.fetchFavoriteWordsByCollectionId(collectionId: collectionId);
  }

  Future<FavoriteDictionaryEntity> fetchFavoriteWordById({required int favoriteWordId}) async {
    return await _useCase.fetchFavoriteWordById(favoriteWordId: favoriteWordId);
  }

  Future<void> addFavoriteWord({required FavoriteDictionaryEntity model}) async {
    await _useCase.fetchAddFavoriteWord(model: model);
    notifyListeners();
  }

  Future<void> changeFavoriteWord({required int favoriteWordId, required int serializableIndex}) async {
    await _useCase.fetchChangeFavoriteWord(wordId: favoriteWordId, serializableIndex: serializableIndex);
    notifyListeners();
  }

  Future<void> moveFavoriteWord({required int wordNumber, required int oldCollectionId, required int collectionId}) async {
    await _useCase.fetchMoveFavoriteWord(wordNr: wordNumber, oldCollectionId: oldCollectionId, collectionId: collectionId);
    notifyListeners();
  }

  Future<void> deleteFavoriteWord({required int favoriteWordId}) async {
    await _useCase.fetchDeleteFavoriteWord(favoriteWordId: favoriteWordId);
    notifyListeners();
  }
}
