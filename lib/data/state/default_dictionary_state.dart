import 'package:flutter/cupertino.dart';

import '../../domain/entities/dictionary_entity.dart';
import '../../domain/usecases/default_dictionary_use_case.dart';
import '../repositories/default_dictionary_data_repository.dart';

class DefaultDictionaryState extends ChangeNotifier {
  final DefaultDictionaryUseCase _dictionaryUseCase = DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  Future<List<DictionaryEntity>> getAllWords() async {
    return await _dictionaryUseCase.fetchAllWords();
  }

  Future<List<DictionaryEntity>> getWordsByRoot({required String wordRoot, required int excludedId}) async {
    return await _dictionaryUseCase.fetchWordsByRoot(wordRoot: wordRoot, excludedId: excludedId);
  }

  Future<List<DictionaryEntity>> searchWords({required String searchQuery, required bool exactMatch}) async {
    return await _dictionaryUseCase.fetchSearchWords(searchQuery: searchQuery, exactMatch: exactMatch);
  }

  Future<DictionaryEntity> getWordById({required int wordNr}) async {
    return await _dictionaryUseCase.fetchWordById(wordNr: wordNr);
  }
}