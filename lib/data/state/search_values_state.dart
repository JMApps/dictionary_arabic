import 'package:flutter/cupertino.dart';

import '../../domain/entities/word_search_entity.dart';
import '../../domain/usecases/search_values_use_case.dart';
import '../repositories/search_values_data_repository.dart';

class SearchValuesState extends ChangeNotifier {
  final SearchValuesUseCase _searchValuesUseCase = SearchValuesUseCase(SearchValuesDataRepository());

  Future<List<WordSearchEntity>> fetchAllSearchValues() async {
    return await _searchValuesUseCase.fetchAllSearchValues();
  }

  Future<int> fetchAddSearchValue({required String searchValue}) async {
    int addSearchValue = await _searchValuesUseCase.fetchAddSearchValue(searchValue: searchValue);
    notifyListeners();
    return addSearchValue;
  }

  Future<int> fetchDeleteSearchValueById({required int searchValueId}) async {
    int deleteSearchValue = await _searchValuesUseCase.fetchDeleteSearchValueById(searchValueId: searchValueId);
    notifyListeners();
    return deleteSearchValue;
  }

  Future<int> fetchDeleteAllSearchValues() async {
    int deleteAllSearchValues = await _searchValuesUseCase.fetchDeleteAllSearchValues();
    notifyListeners();
    return deleteAllSearchValues;
  }
}
