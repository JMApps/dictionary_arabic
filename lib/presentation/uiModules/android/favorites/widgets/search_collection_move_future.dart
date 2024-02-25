import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../widgets/data_text.dart';

class SearchCollectionMoveFuture extends StatefulWidget {
  const SearchCollectionMoveFuture({
    super.key,
    required this.query,
    required this.wordNumber,
    required this.oldCollectionId,
  });

  final String query;
  final int wordNumber;
  final int oldCollectionId;

  @override
  State<SearchCollectionMoveFuture> createState() => _SearchCollectionMoveFutureState();
}

class _SearchCollectionMoveFutureState extends State<SearchCollectionMoveFuture> {
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _recentCollections = [];

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
    return FutureBuilder<List<CollectionEntity>>(
      future: Provider.of<CollectionsState>(context).fetchAllButOneCollections(collectionId: widget.oldCollectionId),
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
                padding: AppStyles.mardingWithoutBottom,
                itemCount: _recentCollections.length,
                itemBuilder: (BuildContext context, int index) {
                  final CollectionEntity collectionModel = _recentCollections[index];
                  return Container(
                    margin: AppStyles.mardingOnlyBottom,
                    child: ListTile(
                      contentPadding: AppStyles.mardingSymmetricHor,
                      shape: AppStyles.mainShapeMini,
                      visualDensity: VisualDensity.compact,
                      tileColor: index.isOdd ? itemOddColor : itemEvenColor,
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        await Provider.of<FavoriteWordsState>(context, listen: false).moveFavoriteWord(
                          wordNumber: widget.wordNumber,
                          oldCollectionId: widget.oldCollectionId,
                          collectionId: collectionModel.id,
                        );
                      },
                      title: Text(
                        collectionModel.title,
                        style: const TextStyle(fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Icon(
                        Icons.folder,
                        color: AppStyles.collectionColors[collectionModel.color],
                      ),
                    ),
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
