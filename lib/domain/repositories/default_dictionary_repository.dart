import '../entities/dictionary_entity.dart';

abstract class DefaultDictionaryRepository {
  Future<List<DictionaryEntity>> getAllWords();

  Future<List<DictionaryEntity>> searchWords({required String arabic, required String translation});

  Future<DictionaryEntity> getWordById({required int wordId});
}
