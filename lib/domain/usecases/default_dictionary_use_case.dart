import '../entities/dictionary_entity.dart';
import '../repositories/default_dictionary_repository.dart';

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

  Future<List<DictionaryEntity>> fetchWordsByRoot({required String wordRoot, required int excludedId}) async {
    try {
      final List<DictionaryEntity> wordsByRoot = await _dictionaryRepository.getWordsByRoot(wordRoot: wordRoot, excludedId: excludedId);
      return wordsByRoot;
    } catch (e) {
      throw Exception('Get words by root data error: $e');
    }
  }

  Future<List<DictionaryEntity>> fetchSearchWords({required String searchQuery, required bool exactMatch}) async {
    try {
      final List<DictionaryEntity> searchResultWords = await _dictionaryRepository.searchWords(searchQuery: searchQuery.replaceAll('ي', 'ى').toLowerCase().trim(), exactMatch: exactMatch);
      return searchResultWords;
    } catch (e) {
      throw Exception('Get search words data error: $e');
    }
  }

  Future<DictionaryEntity> fetchWordById({required int wordNr}) async {
    try {
      final DictionaryEntity wordById = await _dictionaryRepository.getWordById(wordNumber: wordNr);
      return wordById;
    } catch (e) {
      throw Exception('Get word by id data error: $e');
    }
  }


  Future<List<DictionaryEntity>> fetchWordsByQuiz({required int wordNr}) async {
    try {
      final List<DictionaryEntity> wordsByQuiz = await _dictionaryRepository.getWordsByQuiz(wordNumber: wordNr);
      return wordsByQuiz;
    } catch (e) {
      throw Exception('Get words by quiz data error: $e');
    }
  }

}
