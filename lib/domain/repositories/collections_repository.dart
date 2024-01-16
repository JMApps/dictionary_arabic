import 'package:arabic/domain/entities/collection_entity.dart';

abstract class CollectionsRepository {
  Future<List<CollectionEntity>> getAllCollections({required String sortedBy});

  Future<CollectionEntity> getCollectionById({required int collectionId});

  Future<int> getWordCount({required int collectionId});

  Future<int> addCollection({required CollectionEntity model});

  Future<int> changeCollection({required CollectionEntity model});

  Future<int> deleteCollection({required int collectionId});

  Future<int> deleteAllCollections();
}
