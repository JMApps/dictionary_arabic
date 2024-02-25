import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../collections/dialogs/add_collection_dialog.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import 'items/select_item_collection.dart';
import 'widgets/search_collection_add_delegate.dart';

class FavoriteWordSelectCollection extends StatelessWidget {
  const FavoriteWordSelectCollection({
    super.key,
    required this.wordModel,
    required this.serializableIndex,
  });

  final DictionaryEntity wordModel;
  final int serializableIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColors.inversePrimary,
            forceElevated: true,
            centerTitle: true,
            floating: true,
            title: const Text(AppStrings.selectCollection),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchCollectionAddDelegate(
                      wordModel: wordModel,
                      serializableIndex: serializableIndex,
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          FutureBuilder<List<CollectionEntity>>(
            future: Provider.of<CollectionsState>(context).fetchAllCollections(),
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
                      return SelectItemCollection(
                        wordModel: wordModel,
                        serializableIndex: serializableIndex,
                        collectionModel: collectionModel,
                        index: index,
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
                  child: DataText(text: AppStrings.collectionsIfEmpty),
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
