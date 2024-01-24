import 'package:arabic/domain/repositories/default_dictionary_repository.dart';

import '../entities/dictionary_entity.dart';

class DefaultDictionaryUseCase {
  final DefaultDictionaryRepository _dictionaryRepository;

  DefaultDictionaryUseCase(this._dictionaryRepository);

  Future<List<DictionaryEntity>> fetchAllWords() async {
    try {
      final List<DictionaryEntity> allWords = await _dictionaryRepository.getAllWords();
      return allWords;
    } catch (e) {
      throw Exception('Get all words data error: $e');
    }
  }

  Future<List<DictionaryEntity>> fetchWordsByRoot({required String wordRoot}) async {
    try {
      final List<DictionaryEntity> wordsByRoot = await _dictionaryRepository.getWordsByRoot(wordRoot: wordRoot);
      return wordsByRoot;
    } catch (e) {
      throw Exception('Get words by root data error: $e');
    }
  }

  Future<List<DictionaryEntity>> fetchSearchWords({required String searchQuery, required bool exactMatch}) async {
    try {
      final List<DictionaryEntity> searchResultWords = await _dictionaryRepository.searchWords(searchQuery: searchQuery, exactMatch: exactMatch);
      return searchResultWords;
    } catch (e) {
      throw Exception('Get search words data error: $e');
    }
  }

  Future<DictionaryEntity> fetchWordById({required int wordId}) async {
    try {
      final DictionaryEntity wordById = await _dictionaryRepository.getWordById(wordId: wordId);
      return wordById;
    } catch (e) {
      throw Exception('Get word by id data error: $e');
    }
  }
}
