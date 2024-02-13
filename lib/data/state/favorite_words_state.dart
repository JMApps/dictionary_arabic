import 'package:flutter/cupertino.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';
import '../../domain/usecases/favorite_dictionary_use_case.dart';
import '../repositories/favorite_dictionary_data_repository.dart';

class FavoriteWordsState extends ChangeNotifier {
  final FavoriteDictionaryUseCase _useCase = FavoriteDictionaryUseCase(FavoriteDictionaryDataRepository());

  Future<List<FavoriteDictionaryEntity>> fetchAllFavoriteWords() async {
    return await _useCase.fetchAllFavoriteWords();
  }

  Future<bool> fetchIsWordFavorite({required int wordId}) async {
    return await _useCase.fetchIsWordFavorite(wordId: wordId);
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

  Future<void> changeFavoriteWord({required int wordId, required int serializableIndex}) async {
    await _useCase.fetchChangeFavoriteWord(wordId: wordId, serializableIndex: serializableIndex);
    notifyListeners();
  }

  Future<void> moveFavoriteWord({required int wordNr, required int oldCollectionId, required int collectionId}) async {
    await _useCase.fetchMoveFavoriteWord(wordNr: wordNr, oldCollectionId: oldCollectionId, collectionId: collectionId);
    notifyListeners();
  }

  Future<void> deleteFavoriteWord({required int favoriteWordId, required int collectionId}) async {
    await _useCase.fetchDeleteFavoriteWord(favoriteWordId: favoriteWordId, collectionId: collectionId);
    notifyListeners();
  }
}
