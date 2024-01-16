import '../entities/collection_entity.dart';
import '../repositories/collections_repository.dart';

class CollectionsUseCase {
  final CollectionsRepository _collectionsRepository;

  CollectionsUseCase(this._collectionsRepository);

  Future<List<CollectionEntity>> fetchAllCollections({required String sortedBy}) async {
    try {
      final List<CollectionEntity> allCollections = await _collectionsRepository.getAllCollections(sortedBy: sortedBy);
      return allCollections;
    } catch (e) {
      throw Exception('Get all collections data error: $e');
    }
  }

  Future<CollectionEntity> fetchCollectionById({required int collectionId}) async {
    try {
      final CollectionEntity collectionById = await _collectionsRepository.getCollectionById(collectionId: collectionId);
      return collectionById;
    } catch (e) {
      throw Exception('Get collection by id data error: $e');
    }
  }

  Future<int> fetchWordCount({required int collectionId}) async {
    try {
      final int wordCount = await _collectionsRepository.getWordCount(collectionId: collectionId);
      return wordCount;
    } catch (e) {
      throw Exception('Get word count data error: $e');
    }
  }

  Future<int> fetchAddCollection({required CollectionEntity model}) async {
    try {
      final int addCollection = await _collectionsRepository.addCollection(model: model);
      return addCollection;
    } catch (e) {
      throw Exception('Get add collection data error: $e');
    }
  }

  Future<int> fetchChangeCollection({required CollectionEntity model}) async {
    try {
      final int changeCollection = await _collectionsRepository.changeCollection(model: model);
      return changeCollection;
    } catch (e) {
      throw Exception('Get change collection data error: $e');
    }
  }

  Future<int> fetchDeleteCollection({required int collectionId}) async {
    try {
      final int deleteCollection = await _collectionsRepository.deleteCollection(collectionId: collectionId);
      return deleteCollection;
    } catch (e) {
      throw Exception('Get delete collection data error: $e');
    }
  }

  Future<int> fetchDeleteCollections() async {
    try {
      final int deleteAllCollection = await _collectionsRepository.deleteAllCollections();
      return deleteAllCollection;
    } catch (e) {
      throw Exception('Get delete all collections data error: $e');
    }
  }
}
