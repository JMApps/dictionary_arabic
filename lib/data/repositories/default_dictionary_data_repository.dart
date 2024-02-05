import 'package:sqflite/sqflite.dart';

import '../../domain/entities/dictionary_entity.dart';
import '../../domain/repositories/default_dictionary_repository.dart';
import '../models/dictionary_model.dart';
import '../services/default_dictionary_service.dart';

class DefaultDictionaryDataRepository implements DefaultDictionaryRepository {
  final DefaultDictionaryService _dictionaryService = DefaultDictionaryService();
  final String _searchTable = 'Table_of_search';
  final String _dataTable = 'Table_of_dictionary';

  @override
  Future<List<DictionaryEntity>> getAllWords() async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.nr, d.arabic_word, d.form, d.vocalization, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_dataTable d ON s.article_id = d.nr "
    );    final List<DictionaryEntity> allWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return allWords;
  }

  @override
  Future<List<DictionaryEntity>> getWordsByRoot({required String wordRoot, required int excludedId}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.nr, d.arabic_word, d.form, d.vocalization, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_dataTable d ON s.article_id = d.nr "
          "WHERE d.root = ? AND d.nr != ?",
      [wordRoot, excludedId],
    );
    final List<DictionaryEntity> wordsByRoot = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return wordsByRoot;
  }

  @override
  Future<DictionaryEntity> getWordById({required int wordNr}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.nr, d.arabic_word, d.form, d.vocalization, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_dataTable d ON s.article_id = d.nr "
          "WHERE d.nr = ?", [wordNr],
    );    final DictionaryEntity? wordById = resources.isNotEmpty ? _mapToEntity(DictionaryModel.fromMap(resources.first)) : null;
    return wordById!;
  }

  @override
  Future<List<DictionaryEntity>> searchWords({required String searchQuery, required bool exactMatch,}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery("SELECT s.article_id, s.translation, s.arabic, d.id, d.nr, d.arabic_word, d.form, d.vocalization, d.root, d.forms FROM $_searchTable s JOIN $_dataTable d ON s.article_id = d.nr WHERE s.rowid IN (SELECT rowid FROM Table_of_search WHERE translation MATCH ? OR arabic MATCH ?)",
        exactMatch ? ['"$searchQuery"', '"$searchQuery"'] : ['$searchQuery*', '$searchQuery*']
    );
    final List<DictionaryEntity> searchWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return searchWords;
  }

  // Mapping to entity
  DictionaryEntity _mapToEntity(DictionaryModel model) {
    return DictionaryEntity(
      articleId: model.articleId,
      translation: model.translation,
      arabic: model.arabic,
      id: model.id,
      nr: model.nr,
      arabicWord: model.arabicWord,
      form: model.form,
      vocalization: model.vocalization,
      root: model.root,
      forms: model.forms,
    );
  }
}
