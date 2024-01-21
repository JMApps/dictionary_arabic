import '../entities/word_search_entity.dart';

abstract class SearchValuesRepository {
  Future<List<WordSearchEntity>> getAllSearchValues();

  Future<int> addSearchValue({required String searchValue});

  Future<int> deleteSearchValueById({required int searchValueId});

  Future<int> deleteAllSearchValues();
}
