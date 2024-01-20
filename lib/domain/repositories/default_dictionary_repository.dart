import '../entities/dictionary_entity.dart';

abstract class DefaultDictionaryRepository {
  Future<List<DictionaryEntity>> getAllWords();

  Future<List<DictionaryEntity>> searchWords({required String searchQuery});

  Future<DictionaryEntity> getWordById({required int wordId});
}
