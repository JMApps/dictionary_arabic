import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../collections/dialogs/add_collection_dialog.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import 'widgets/search_collection_move_delegate.dart';

class MoveFavoriteWordPage extends StatelessWidget {
  const MoveFavoriteWordPage({
    super.key,
    required this.wordNumber,
    required this.oldCollectionId,
  });

  final int wordNumber;
  final int oldCollectionId;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColors.inversePrimary,
            centerTitle: true,
            floating: true,
            forceElevated: true,
            title: const Text(AppStrings.moveTo),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchCollectionMoveDelegate(
                      wordNumber: wordNumber,
                      oldCollectionId: oldCollectionId,
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          FutureBuilder<List<CollectionEntity>>(
            future: Provider.of<CollectionsState>(context).fetchAllButOneCollections(collectionId: oldCollectionId),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: ListView.builder(
                    padding: AppStyles.mardingWithoutBottom,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CollectionEntity collectionModel = snapshot.data![index];
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
                              wordNumber: wordNumber,
                              oldCollectionId: oldCollectionId,
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
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: ErrorDataText(errorText: snapshot.error.toString()),
                );
              } else {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: DataText(text: AppStrings.collectionButOneIsEmpty),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddCollectionDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
