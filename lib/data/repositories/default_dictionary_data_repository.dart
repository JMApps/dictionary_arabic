import 'package:sqflite/sqflite.dart';

import '../../domain/entities/dictionary_entity.dart';
import '../../domain/repositories/default_dictionary_repository.dart';
import '../models/dictionary_model.dart';
import '../services/default_dictionary_service.dart';

class DefaultDictionaryDataRepository implements DefaultDictionaryRepository {
  final DefaultDictionaryService _dictionaryService = DefaultDictionaryService();
  final String _searchTable = 'Table_of_search';
  final String _wordsDataTable = 'Table_of_dictionary';

  @override
  Future<List<DictionaryEntity>> getAllWords() async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number "
    );
    final List<DictionaryEntity> allWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return allWords;
  }

  @override
  Future<List<DictionaryEntity>> getWordsByRoot({required String wordRoot, required int excludedId}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number "
          "WHERE d.root = ? AND d.word_number != ?",
      [wordRoot, excludedId],
    );
    final List<DictionaryEntity> wordsByRoot = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return wordsByRoot;
  }

  @override
  Future<DictionaryEntity> getWordById({required int wordNumber}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery(
      "SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms "
          "FROM $_searchTable s "
          "INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number "
          "WHERE d.word_number = ?", [wordNumber],
    );
    final DictionaryEntity? wordById = resources.isNotEmpty ? _mapToEntity(DictionaryModel.fromMap(resources.first)) : null;
    return wordById!;
  }

  @override
  Future<List<DictionaryEntity>> searchWords({required String searchQuery, required bool exactMatch,}) async {
    final Database database = await _dictionaryService.db;
    final List<Map<String, Object?>> resources = await database.rawQuery("SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms FROM $_searchTable s JOIN $_wordsDataTable d ON s.article_id = d.word_number WHERE s.rowid IN (SELECT rowid FROM $_searchTable WHERE translation MATCH ? OR arabic MATCH ?)",
        exactMatch ? ['"$searchQuery"', '"$searchQuery"'] : ['$searchQuery*', '$searchQuery*']
    );
    final List<DictionaryEntity> searchWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(DictionaryModel.fromMap(c))).toList() : [];
    return searchWords;
  }

  @override
  Future<List<DictionaryEntity>> getWordsByQuiz({required int wordNumber}) async {
    final Database database = await _dictionaryService.db;

    final List<Map<String, Object?>> wordResult = await database.rawQuery('''
    SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms
    FROM $_searchTable s
    INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number
    WHERE d.word_number = ?
  ''', [wordNumber]);

    final List<DictionaryEntity> resultList = [];

    if (wordResult.isNotEmpty) {
      final DictionaryModel word = DictionaryModel.fromMap(wordResult.first);
      resultList.add(_mapToEntity(word));

      final List<Map<String, Object?>> optionsResult = await database.rawQuery('''
      SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms
      FROM $_searchTable s
      INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number
      WHERE d.word_number > ?
      ORDER BY d.word_number ASC
      LIMIT 3
    ''', [wordNumber]);

      if (optionsResult.length < 3) {
        final List<Map<String, Object?>> precedingResult = await database.rawQuery('''
        SELECT s.article_id, s.translation, s.arabic, d.id, d.word_number, d.arabic_word, d.form, d.additional, d.vocalization, d.homonym_nr, d.root, d.forms
        FROM $_searchTable s
        INNER JOIN $_wordsDataTable d ON s.article_id = d.word_number
        WHERE d.word_number < ?
        ORDER BY d.word_number DESC
        LIMIT 3
      ''', [wordNumber]);

        for (var precedingOption in precedingResult.reversed) {
          final DictionaryModel optionWord = DictionaryModel.fromMap(precedingOption);
          if (!resultList.contains(_mapToEntity(optionWord))) {
            resultList.insert(0, _mapToEntity(optionWord));
          }
        }
      }

      for (final option in optionsResult) {
        final DictionaryModel optionWord = DictionaryModel.fromMap(option);
        if (!resultList.contains(_mapToEntity(optionWord))) {
          resultList.add(_mapToEntity(optionWord));
        }
      }
    }

    return resultList;
  }

  // Mapping to entity
  DictionaryEntity _mapToEntity(DictionaryModel model) {
    return DictionaryEntity(
      articleId: model.articleId,
      translation: model.translation,
      arabic: model.arabic,
      id: model.id,
      wordNumber: model.wordNumber,
      arabicWord: model.arabicWord,
      form: model.form,
      additional: model.additional,
      vocalization: model.vocalization,
      homonymNr: model.homonymNr,
      root: model.root,
      forms: model.forms,
    );
  }
}
