import '../entities/dictionary_entity.dart';

abstract class DefaultDictionaryRepository {
  Future<List<DictionaryEntity>> getAllWords();

  Future<List<DictionaryEntity>> getWordsByRoot({required String wordRoot, required int excludedId});

  Future<List<DictionaryEntity>> searchWords({required String searchQuery, required bool exactMatch});

  Future<DictionaryEntity> getWordById({required int wordNumber});

  Future<List<DictionaryEntity>> getWordsByQuiz({required int wordNumber});
}
