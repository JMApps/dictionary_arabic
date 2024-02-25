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

    await database.insert(_favoriteWordsTableName, favoriteWordModel.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
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
    final Map<String, int> toCollectionMap = {
      'collection_id': collectionId,
    };
    await database.update(_favoriteWordsTableName, toCollectionMap, where: 'word_number = ?', whereArgs: [wordNr], conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteFavoriteWord({required int favoriteWordId}) async {
    final Database database = await _collectionsService.db;
    await database.delete(_favoriteWordsTableName, where: 'word_number = ?', whereArgs: [favoriteWordId]);
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
