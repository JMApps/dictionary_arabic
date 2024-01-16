import 'package:flutter/cupertino.dart';

import '../../domain/entities/collection_entity.dart';
import '../../domain/usecases/collections_use_case.dart';
import '../repositories/collections_data_repository.dart';

class CollectionsState extends ChangeNotifier {
  final CollectionsUseCase _useCase = CollectionsUseCase(CollectionsDataRepository());

  Future<List<CollectionEntity>> fetchAllCollections({required String sortedBy}) async {
    return await _useCase.fetchAllCollections(sortedBy: sortedBy);
  }

  Future<CollectionEntity> getCollectionById({required int collectionId}) async {
    return await _useCase.fetchCollectionById(collectionId: collectionId);
  }

  Future<int> getWordCount({required int collectionId}) async {
    int getWordCount = await _useCase.fetchWordCount(collectionId: collectionId);
    notifyListeners();
    return getWordCount;
  }

  Future<int> addCollection({required CollectionEntity model}) async {
    int addCollection = await _useCase.fetchAddCollection(model: model);
    notifyListeners();
    return addCollection;
  }

  Future<int> changeCollection({required CollectionEntity model}) async {
    int changeCollection = await _useCase.fetchChangeCollection(model: model);
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
}
