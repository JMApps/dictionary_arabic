import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/strings/app_constraints.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/usecases/collections_use_case.dart';
import '../repositories/collections_data_repository.dart';

class CollectionsState extends ChangeNotifier {
  final Box _mainSettingsBox = Hive.box(AppConstraints.keyMainAppSettingsBox);
  final CollectionsUseCase _useCase = CollectionsUseCase(CollectionsDataRepository());

  CollectionsState() {
    _orderCollectionIndex = _mainSettingsBox.get(AppConstraints.keyOrderCollectionIndex, defaultValue: 0);
    _orderIndex = _mainSettingsBox.get(AppConstraints.keyOrderIndex, defaultValue: 1);
  }

  late int _orderCollectionIndex;

  int get getOrderCollectionIndex => _orderCollectionIndex;

  set setOrderCollectionIndex(int index) {
    _orderCollectionIndex = index;
    _mainSettingsBox.put(AppConstraints.keyOrderCollectionIndex, _orderCollectionIndex);
    notifyListeners();
  }

  late int _orderIndex;

  int get getOrderIndex => _orderIndex;

  set setOrderIndex(int index) {
    _orderIndex = index;
    _mainSettingsBox.put(AppConstraints.keyOrderIndex, _orderIndex);
    notifyListeners();
  }

  final List<String> _collectionOrder = [
    'id',
    'color',
    'words_count',
  ];

  final List<String> _order = [
    'ASC',
    'DESC',
  ];

  Future<List<CollectionEntity>> fetchAllCollections() async {
    return await _useCase.fetchAllCollections(sortedBy: '${_collectionOrder[_orderCollectionIndex]} ${_order[_orderIndex]}');
  }

  Future<List<CollectionEntity>> fetchAllButOneCollections({required int collectionId}) async {
    return await _useCase.fetchAllButOneCollections(collectionId: collectionId, sortedBy: '${_collectionOrder[_orderCollectionIndex]} ${_order[_orderIndex]}');
  }

  Future<CollectionEntity> getCollectionById({required int collectionId}) async {
    return await _useCase.fetchCollectionById(collectionId: collectionId);
  }

  Future<int> addCollection({required CollectionEntity collectionModel}) async {
    int addCollection = await _useCase.fetchAddCollection(model: collectionModel);
    notifyListeners();
    return addCollection;
  }

  Future<int> changeCollection({required CollectionEntity collectionModel}) async {
    int changeCollection = await _useCase.fetchChangeCollection(model: collectionModel);
    notifyListeners();
    return changeCollection;
  }

  Future<int> deleteCollection({required int collectionId}) async {
    int deleteCollection = await _useCase.fetchDeleteCollection(collectionId: collectionId);
    notifyListeners();
    return deleteCollection;
  }

  Future<int> deleteAllCollections() async {
    int deleteAllCollections = await _useCase.fetchDeleteCollections();
    notifyListeners();
    return deleteAllCollections;
  }

  Future<int> getWordCount({required int collectionId}) async {
    return _useCase.fetchWordCount(collectionId: collectionId);
  }
}
