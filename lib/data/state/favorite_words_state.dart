import 'package:flutter/cupertino.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';
import '../../domain/usecases/favorite_dictionary_use_case.dart';
import '../repositories/favorite_dictionary_data_repository.dart';

class FavoriteWordsState extends ChangeNotifier {
  final FavoriteDictionaryUseCase _useCase = FavoriteDictionaryUseCase(FavoriteDictionaryDataRepository());

  int _translationIndex = -1;

  int get getTranslationIndex => _translationIndex;

  set setTranslationIndex(int value) {
    _translationIndex = value;
    notifyListeners();
  }

  Future<List<FavoriteDictionaryEntity>> fetchAllFavoriteWords() async {
    return await _useCase.fetchAllFavoriteWords();
  }

  Future<List<FavoriteDictionaryEntity>> fetchFavoriteWordsByCollectionId({required int collectionId}) async {
    return await _useCase.fetchFavoriteWordsByCollectionId(collectionId: collectionId);
  }

  Future<FavoriteDictionaryEntity> fetchFavoriteWordById({required int favoriteWordId}) async {
    return await _useCase.fetchFavoriteWordById(favoriteWordId: favoriteWordId);
  }

  Future<int> addFavoriteWord({required FavoriteDictionaryEntity model}) async {
    int addFavoriteWord = await _useCase.fetchAddFavoriteWord(model: model);
    notifyListeners();
    return addFavoriteWord;
  }

  Future<int> changeFavoriteWord({required int wordId, required int serializableIndex}) async {
    int changeFavoriteWord = await _useCase.fetchChangeFavoriteWord(wordId: wordId, serializableIndex: serializableIndex);
    notifyListeners();
    return changeFavoriteWord;
  }

  Future<int> deleteFavoriteWord({required int favoriteWordId}) async {
    int deleteFavoriteWord = await _useCase.fetchDeleteFavoriteWord(favoriteWordId: favoriteWordId);
    notifyListeners();
    return deleteFavoriteWord;
  }
}
