import '../entities/collection_entity.dart';

abstract class CollectionsRepository {
  Future<List<CollectionEntity>> getAllCollections({required String sortedBy});

  Future<List<CollectionEntity>> getAllButOneCollection({required int collectionId, required String sortedBy});

  Future<CollectionEntity> getCollectionById({required int collectionId});

  Future<int> getWordCount({required int collectionId});

  Future<void> addCollection({required Map<String, dynamic> mapCollection});

  Future<void> changeCollection({required Map<String, dynamic> mapCollection});

  Future<int> deleteCollection({required int collectionId});

  Future<int> deleteAllCollections();
}
