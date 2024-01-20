import 'package:sqflite/sqflite.dart';

import '../../domain/entities/dictionary_entity.dart';
import '../../domain/repositories/default_dictionary_repository.dart';
import '../models/dictionary_model.dart';
import '../services/default_dictionary_service.dart';

class DefaultDictionaryDataRepository implements DefaultDictionaryRepository {
  final DefaultDictionaryService _dictionaryService = DefaultDictionaryService();
  final String tableName = 'Table_of_search_fts';

  @override
  Future<List<DictionaryEntity>> getAllWords() async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.query(tableName);
    final List<DictionaryEntity> allWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return allWords;
  }

  @override
  Future<DictionaryEntity> getWordById({required int wordId}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.query(tableName, where: 'id = ?', whereArgs: [wordId]);
    final DictionaryEntity? wordById = resources.isNotEmpty ? _mapToEntity(DictionaryModel.fromMap(resources.first)) : null;
    return wordById!;
  }

  @override
  Future<List<DictionaryEntity>> searchWords({required String searchQuery}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
        "SELECT * FROM $tableName WHERE arabic_word_wh MATCH ? OR short_meaning MATCH ?",
        ['$searchQuery*', '$searchQuery*']
    );
    final List<DictionaryEntity> searchWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return searchWords;
  }

  // Mapping to entity
  DictionaryEntity _mapToEntity(DictionaryModel model) {
    return DictionaryEntity(
      id: model.id,
      arabicWord: model.arabicWord,
      arabicWordWH: model.arabicWordWH,
      arabicRoot: model.arabicRoot,
      plural: model.plural,
      meaning: model.meaning,
      shortMeaning: model.shortMeaning,
      other: model.other,
    );
  }
}
