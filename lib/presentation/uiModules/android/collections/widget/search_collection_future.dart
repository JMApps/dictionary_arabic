import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../widgets/data_text.dart';
import '../items/collection_item.dart';

class SearchCollectionFuture extends StatefulWidget {
  const SearchCollectionFuture({super.key, required this.query});

  final String query;

  @override
  State<SearchCollectionFuture> createState() => _SearchCollectionFutureState();
}

class _SearchCollectionFutureState extends State<SearchCollectionFuture> {
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _recentCollections = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollectionEntity>>(
      future: Provider.of<CollectionsState>(context).fetchAllCollections(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _collections = snapshot.data!;
          _recentCollections = widget.query.isEmpty
              ? _collections
              : _collections.where((element) => element.title.toLowerCase().contains(widget.query.toLowerCase())).toList();
          if (_recentCollections.isEmpty && widget.query.isNotEmpty) {
            return const DataText(text: AppStrings.queryIsEmpty);
          } else if (_recentCollections.isEmpty) {
            return const DataText(text: AppStrings.collectionsIfEmpty);
          } else {
            return Scrollbar(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _recentCollections.length,
                itemBuilder: (BuildContext context, int index) {
                  final CollectionEntity collectionModel = _recentCollections[index];
                  return CollectionItem(
                    collectionModel: collectionModel,
                    index: index,
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
