import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../../domain/entities/word_search_entity.dart';
import '../../domain/repositories/search_values_repository.dart';
import '../models/word_search_model.dart';
import '../services/collections_service.dart';

class CollectionsDataRepository implements SearchValuesRepository {
  final CollectionsService _collectionsService = CollectionsService();
  final String _tableName = 'Table_of_searched_values';

  @override
  Future<List<WordSearchEntity>> getAllSearchValues() async {
    final Database database = await _collectionsService.db;
    final List<Map<String, Object?>> resources = await database.query(_tableName);
    final List<WordSearchEntity> allSearchValues = resources.isNotEmpty ? resources.map((c) => _mapToEntity(WordSearchModel.fromMap(c))).toList() : [];
    return allSearchValues;
  }

  @override
  Future<int> addSearchValue({required String searchValue}) async {
    final Database database = await _collectionsService.db;
    WordSearchModel searchModel = WordSearchModel(
      id: 0,
      searchValue: searchValue,
    );
    final int addSearchValue = await database.insert(_tableName, searchModel.toMap(), conflictAlgorithm: sql.ConflictAlgorithm.ignore);
    return addSearchValue;
  }

  @override
  Future<int> deleteSearchValueById({required int searchValueId}) async {
    final Database database = await _collectionsService.db;
    final int deleteSearchValue = await database.delete(_tableName, where: 'id = ?', whereArgs: [searchValueId]);
    return deleteSearchValue;
  }

  @override
  Future<int> deleteAllSearchValues() async {
    final Database database = await _collectionsService.db;
    final int deleteAllSearchValues = await database.delete(_tableName);
    return deleteAllSearchValues;
  }

  // Mapping to entity
  WordSearchEntity _mapToEntity(WordSearchModel model) {
    return WordSearchEntity(
      id: model.id,
      searchValue: model.searchValue,
    );
  }
}
