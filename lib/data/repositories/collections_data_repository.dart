import 'package:arabic/data/models/collection_model.dart';
import 'package:arabic/data/services/collections_service.dart';
import 'package:arabic/domain/entities/collection_entity.dart';
import 'package:arabic/domain/repositories/collections_repository.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class CollectionsDataRepository implements CollectionsRepository {
  final CollectionsService _collectionsService = CollectionsService();
  final String _tableName = 'Table_of_collections';
  final String _wordsTableName = 'Table_of_favorite_words';

  @override
  Future<List<CollectionEntity>> getAllCollections({required String sortedBy}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName, orderBy: sortedBy);
    final List<CollectionEntity> allCollections = resources.isNotEmpty ? resources.map((c) => _mapToEntity(CollectionModel.fromMap(c))).toList() : [];
    return allCollections;
  }

  @override
  Future<CollectionEntity> getCollectionById({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName, where: 'id = ?', whereArgs: [collectionId]);
    final CollectionEntity? collectionById = resources.isNotEmpty ? _mapToEntity(CollectionModel.fromMap(resources.first)) : null;
    return collectionById!;
  }

  @override
  Future<int> getWordCount({required int collectionId}) async {

    final Database database = await _collectionsService.db;

    List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT COUNT(*) as word_count 
    FROM Table_of_favorite_words 
    WHERE collection_id = ?
  ''', [collectionId]);

    if (result.isNotEmpty) {
      Map<String, dynamic> wordCountData = result.first;
      int? wordCount = wordCountData['word_count'];

      if (wordCount != null) {
        return wordCount;
      }
    }
    return 0;
  }

  @override
  Future<int> addCollection({required CollectionEntity model}) async {
    final Database database = await _collectionsService.db;
    CollectionModel collectionModel = CollectionModel(
      id: model.id,
      title: model.title,
      wordsCount: model.wordsCount,
      color: model.color,
    );
    final int addCollection = await database.insert(_tableName, collectionModel.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return addCollection;
  }

  @override
  Future<int> changeCollection({required CollectionEntity model}) async {
    final Database database = await _collectionsService.db;
    CollectionModel collectionModel = CollectionModel(
      id: model.id,
      title: model.title,
      wordsCount: model.wordsCount,
      color: model.color,
    );
    final int changeCollection = await database.update(_tableName, collectionModel.toMap(), where: 'id = ?', whereArgs: [model.id]);
    return changeCollection;
  }

  @override
  Future<int> deleteCollection({required int collectionId}) async {
    final Database database = await _collectionsService.db;
    final int deleteCollection = await database.delete(_tableName, where: 'id = ?', whereArgs: [collectionId]);
    await database.delete(_wordsTableName, where: 'collection_id = ?', whereArgs: [collectionId]);
    return deleteCollection;
  }

  @override
  Future<int> deleteAllCollections() async {
    final Database database = await _collectionsService.db;
    final int deleteAllCollections = await database.delete(_tableName);
    await database.delete(_wordsTableName);
    return deleteAllCollections;
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
