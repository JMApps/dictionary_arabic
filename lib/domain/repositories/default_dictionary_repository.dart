import '../entities/dictionary_entity.dart';

abstract class DefaultDictionaryRepository {
  Future<List<DictionaryEntity>> getAllWords();

  Future<List<DictionaryEntity>> getWordsByRoot({required String wordRoot});

  Future<List<DictionaryEntity>> searchWords({required String searchQuery, required bool exactMatch});

  Future<DictionaryEntity> getWordById({required int wordId});
}
