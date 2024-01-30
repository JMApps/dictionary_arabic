import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/favorite_dictionary_entity.dart';
import '../../domain/repositories/favorite_dictionary_repository.dart';
import '../models/favorite_dictionary_model.dart';
import '../services/collections_service.dart';

class FavoriteDictionaryDataRepository implements FavoriteDictionaryRepository {
  final CollectionsService _collectionsService = CollectionsService();
  final String _tableName = 'Table_of_favorite_words';

  @override
  Future<List<FavoriteDictionaryEntity>> getAllFavoriteWords() async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName);
    final List<FavoriteDictionaryEntity> allFavoriteWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(FavoriteDictionaryModel.fromMap(c))).toList() : [];
    return allFavoriteWords;
  }

  @override
  Future<List<FavoriteDictionaryEntity>> getFavoriteWordsByCollectionId({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName, where: 'collection_id = ?', whereArgs: [collectionId]);
    final List<FavoriteDictionaryEntity> collectionFavoriteWords = resources.isNotEmpty ? resources.map((c) => _mapToEntity(FavoriteDictionaryModel.fromMap(c))).toList() : [];
    return collectionFavoriteWords;
  }

  @override
  Future<FavoriteDictionaryEntity> getFavoriteWordById({required int favoriteWordId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName, where: 'id = ?', whereArgs: [favoriteWordId]);
    final FavoriteDictionaryEntity? favoriteWordById = resources.isNotEmpty ? _mapToEntity(FavoriteDictionaryModel.fromMap(resources.first)) : null;
    return favoriteWordById!;
  }

  @override
  Future<int> addFavoriteWord({required FavoriteDictionaryEntity model}) async {
    final Database database = await _collectionsService.db;
    FavoriteDictionaryModel favoriteWordModel = FavoriteDictionaryModel(
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
      collectionId: model.collectionId,
      serializableIndex: model.serializableIndex,
    );
    final int addFavoriteWord = await database.insert(_tableName, favoriteWordModel.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return addFavoriteWord;
  }

  @override
  Future<int> changeFavoriteWord({required int wordId, required int serializableIndex}) async {
    final Database database = await _collectionsService.db;
    final Map<String, int> serializableMap = {
      'serializable_index': serializableIndex,
    };
    final int changeFavoriteWord = await database.update(_tableName, serializableMap, where: 'id = ?', whereArgs: [wordId], conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return changeFavoriteWord;
  }

  @override
  Future<int> deleteFavoriteWord({required int favoriteWordId}) async {
    final Database database = await _collectionsService.db;
    final int deleteFavoriteWord = await database.delete(_tableName, where: 'id = ?', whereArgs: [favoriteWordId]);
    return deleteFavoriteWord;
  }

  // Mapping to entity
  FavoriteDictionaryEntity _mapToEntity(FavoriteDictionaryModel model) {
    return FavoriteDictionaryEntity(
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
      collectionId: model.collectionId,
      serializableIndex: model.serializableIndex,
    );
  }
}
