import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';
import '../../domain/repositories/favorite_dictionary_repository.dart';
import '../models/favorite_dictionary_model.dart';
import '../services/collections_service.dart';

class FavoriteDictionaryDataRepository implements FavoriteDictionaryRepository {
  final CollectionsService _collectionsService = CollectionsService();
  final String _favoriteWordsTableName = 'Table_of_favorite_words';

  @override
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords() async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_favoriteWordsTableName);
    final List<FavoriteDictionaryEntity> allFavoriteWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(FavoriteDictionaryModel.fromMap(c))).toList() : [];
    return allFavoriteWords;
  }

  @override
  Future<bool> isWordFavorite({required int wordNumber}) async {
    try {
      final Database database = await _collectionsService.db;
      final List<Map<String, Object?>> isFavorite = await database.query(
        _favoriteWordsTableName,
        where: 'word_number = ?',
        whereArgs: [wordNumber],
      );
      return isFavorite.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_favoriteWordsTableName, where: 'collection_id = ?', whereArgs: [collectionId]);
    final List<FavoriteDictionaryEntity> collectionFavoriteWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(FavoriteDictionaryModel.fromMap(c))).toList() : [];
    return collectionFavoriteWords;
  }

  @override
  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_favoriteWordsTableName, where: 'word_number = ?', whereArgs: [favoriteWordId]);
    final FavoriteDictionaryEntity? favoriteWordById = resources.isNotEmpty ? _mapToEntity(FavoriteDictionaryModel.fromMap(resources.first)) : null;
    return favoriteWordById!;
  }

  @override
  Future<void> addFavoriteWord({required FavoriteDictionaryEntity model}) async {
    final Database database = await _collectionsService.db;

    FavoriteDictionaryModel favoriteWordModel = FavoriteDictionaryModel(
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
      collectionId: model.collectionId,
      serializableIndex: model.serializableIndex,
      ankiCount: model.ankiCount,
    );

    await database.transaction((txn) async {
      await txn.insert(_favoriteWordsTableName, favoriteWordModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      await _updateCollectionWordCount(txn, model.collectionId);
    });
  }

  @override
  Future<void> changeFavoriteWord({required int wordId, required int serializableIndex}) async {
    final Database database = await _collectionsService.db;
    final Map<String, int> serializableMap = {
      'serializable_index': serializableIndex,
    };
    await database.update(_favoriteWordsTableName, serializableMap, where: 'word_number = ?', whereArgs: [wordId], conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  @override
  Future<void> moveFavoriteWord({required int wordNr, required int oldCollectionId, required int collectionId}) async {
    final Database database = await _collectionsService.db;
    await database.transaction((txn) async {
      await txn.update(_favoriteWordsTableName, {'collection_id': collectionId}, where: 'word_number = ?', whereArgs: [wordNr], conflictAlgorithm: ConflictAlgorithm.replace);
      await _updateCollectionWordCount(txn, oldCollectionId);
      await _updateCollectionWordCount(txn, collectionId);
    });
  }

  @override
  Future<void> deleteFavoriteWord({required int favoriteWordId}) async {
    final Database database = await _collectionsService.db;
    final word = await getFavoriteWordById(favoriteWordId: favoriteWordId);
    await database.transaction((txn) async {
        await txn.delete(_favoriteWordsTableName, where: 'word_number = ?', whereArgs: [favoriteWordId]);
        await _updateCollectionWordCount(txn, word.collectionId);
      },
    );
  }

  Future<void> _updateCollectionWordCount(sql.Transaction txn, int collectionId) async {
    final wordsCountResult = await txn.rawQuery('''
      SELECT COUNT(*) AS cnt FROM $_favoriteWordsTableName WHERE collection_id = ?
    ''', [collectionId]);
    final wordsCount = wordsCountResult.first['cnt'] as int;
    await txn.update('Table_of_collections', {'words_count': wordsCount}, where: 'id = ?', whereArgs: [collectionId]);
  }

  // Mapping to entity
  FavoriteDictionaryEntity _mapToEntity(FavoriteDictionaryModel model) {
    return FavoriteDictionaryEntity(
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
      collectionId: model.collectionId,
      serializableIndex: model.serializableIndex,
      ankiCount: model.ankiCount
    );
  }
}
