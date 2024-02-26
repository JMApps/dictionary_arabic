import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/data_text.dart';

class SearchCollectionAddFuture extends StatefulWidget {
  const SearchCollectionAddFuture({
    super.key,
    required this.query,
    required this.wordModel,
    required this.serializableIndex,
  });

  final String query;
  final DictionaryEntity wordModel;
  final int serializableIndex;

  @override
  State<SearchCollectionAddFuture> createState() => _SearchCollectionAddFutureState();
}

class _SearchCollectionAddFutureState extends State<SearchCollectionAddFuture> {
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _recentCollections = [];

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
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
                        Navigator.pop(context);
                        final favoriteWordModel = FavoriteDictionaryEntity(
                          articleId: widget.wordModel.articleId,
                          translation: widget.wordModel.translation,
                          arabic: widget.wordModel.arabic,
                          id: widget.wordModel.id,
                          wordNumber: widget.wordModel.wordNumber,
                          arabicWord: widget.wordModel.arabicWord,
                          form: widget.wordModel.form,
                          additional: widget.wordModel.additional,
                          vocalization: widget.wordModel.vocalization,
                          homonymNr: widget.wordModel.homonymNr,
                          root: widget.wordModel.root,
                          forms: widget.wordModel.forms,
                          collectionId: collectionModel.id,
                          serializableIndex: widget.serializableIndex,
                          ankiCount: 0,
                        );
                        await Provider.of<FavoriteWordsState>(context, listen: false).addFavoriteWord(model: favoriteWordModel);
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
                      trailing: FutureBuilder<int>(
                        future: Provider.of<CollectionsState>(context, listen: false).getWordCount(collectionId: collectionModel.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.toString(),
                              style: const TextStyle(fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
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
