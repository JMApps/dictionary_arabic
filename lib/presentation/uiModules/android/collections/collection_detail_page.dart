import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../favorites/items/favorite_word_item.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';

class CollectionDetailPage extends StatelessWidget {
  const CollectionDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColors.inversePrimary,
            stretch: true,
            forceElevated: true,
            centerTitle: true,
            title: Text(collectionModel.title),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          FutureBuilder<List<FavoriteDictionaryEntity>>(
            future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
              collectionId: collectionModel.id,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverList.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final FavoriteDictionaryEntity model = snapshot.data![index];
                    return FavoriteWordItem(model: model);
                  },
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorDataText(errorText: snapshot.error.toString()),
                );
              } else {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: DataText(text: AppStrings.favoriteWordsIfEmpty),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
