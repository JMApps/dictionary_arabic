import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/collection_entity.dart';
import '../../domain/repositories/collections_repository.dart';
import '../models/collection_model.dart';
import '../services/collections_service.dart';

class CollectionsDataRepository implements CollectionsRepository {
  final CollectionsService _collectionsService = CollectionsService();
  final String _collectionsTableName = 'Table_of_collections';
  final String _favoriteWordsTableName = 'Table_of_favorite_words';

  @override
  Future<List<CollectionEntity>> getAllCollections({required String sortedBy}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_collectionsTableName, orderBy: sortedBy);
    final List<CollectionEntity> allCollections = resources.isNotEmpty ? resources.map((c) => _mapToEntity(CollectionModel.fromMap(c))).toList() : [];
    return allCollections;
  }

  @override
  Future<List<CollectionEntity>> getAllButOneCollection({required int collectionId, required String sortedBy}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_collectionsTableName, where: 'id <> ?', whereArgs: [collectionId], orderBy: sortedBy);
    final List<CollectionEntity> allCollections = resources.isNotEmpty ? resources.map((c) => _mapToEntity(CollectionModel.fromMap(c))).toList() : [];
    return allCollections;
  }

  @override
  Future<CollectionEntity> getCollectionById({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_collectionsTableName, where: 'id = ?', whereArgs: [collectionId]);
    final CollectionEntity? collectionById = resources.isNotEmpty ? _mapToEntity(CollectionModel.fromMap(resources.first)) : null;
    return collectionById!;
  }

  @override
  Future<void> addCollection({required Map<String, dynamic> mapCollection}) async {
    final Database database = await _collectionsService.db;
    await database.insert(_collectionsTableName, mapCollection, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  @override
  Future<void> changeCollection({required Map<String, dynamic> mapCollection}) async {
    final Database database = await _collectionsService.db;
    await database.update(_collectionsTableName, mapCollection, where: 'id = ?', whereArgs: [mapCollection['id']]);
  }

  @override
  Future<int> deleteCollection({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final int deleteCollection = await database.delete(_collectionsTableName, where: 'id = ?', whereArgs: [collectionId]);
    await database.delete(_favoriteWordsTableName, where: 'collection_id = ?', whereArgs: [collectionId]);
    return deleteCollection;
  }

  @override
  Future<int> deleteAllCollections() async {
    final Database database = await _collectionsService.db;
    final int deleteAllCollections = await database.delete(_collectionsTableName);
    await database.delete(_favoriteWordsTableName);
    return deleteAllCollections;
  }

  @override
  Future<int> getWordCount({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final wordsCountMaps = await database.query(_collectionsTableName, where: 'id = ?', whereArgs: [collectionId], columns: ['words_count']);
    _getWordsCount(collectionId);
    return wordsCountMaps.first['words_count'] as int;
  }

  Future<void> _getWordsCount(int collectionId) async {
    final Database database = await _collectionsService.db;
    var result = await database.rawQuery('''SELECT COUNT(*) AS cnt FROM $_favoriteWordsTableName WHERE collection_id = $collectionId''');
    int wordsCount = result.first['cnt'] as int;
    await database.update('Table_of_collections', {'words_count': wordsCount}, where: 'id = ?', whereArgs: [collectionId]);
  }

  // Mapping to entity
  CollectionEntity _mapToEntity(CollectionModel model) {
    return CollectionEntity(
      id: model.id,
      title: model.title,
      wordsCount: model.wordsCount,
      color: model.color,
    );
  }
}
