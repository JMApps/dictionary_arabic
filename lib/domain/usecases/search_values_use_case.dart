import '../entities/word_search_entity.dart';
import '../repositories/search_values_repository.dart';

class SearchValuesUseCase {
  final SearchValuesRepository _searchValuesRepository;

  SearchValuesUseCase(this._searchValuesRepository);

  Future<List<WordSearchEntity>> fetchAllSearchValues() async {
    try {
      final List<WordSearchEntity> allSearchValues = await _searchValuesRepository.getAllSearchValues();
      return allSearchValues;
    } catch (e) {
      throw Exception('Get all search values data error: $e');
    }
  }

  Future<int> fetchAddSearchValue({required String searchValue}) async {
    try {
      final int addSearchValue = await _searchValuesRepository.addSearchValue(searchValue: searchValue);
      return addSearchValue;
    } catch (e) {
      throw Exception('Get add search value data error: $e');
    }
  }

  Future<int> fetchDeleteSearchValueById({required int searchValueId}) async {
    try {
      final int deleteSearchValue = await _searchValuesRepository.deleteSearchValueById(searchValueId: searchValueId);
      return deleteSearchValue;
    } catch (e) {
      throw Exception('Get delete search value data error: $e');
    }
  }

  Future<int> fetchDeleteAllSearchValues() async {
    try {
      final int deleteAllSearchValues = await _searchValuesRepository.deleteAllSearchValues();
      return deleteAllSearchValues;
    } catch (e) {
      throw Exception('Get delete all search values data error: $e');
    }
  }
}