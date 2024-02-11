import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../favorites/items/favorite_word_item.dart';
import '../widgets/error_data_text.dart';

class CollectionDetailPage extends StatelessWidget {
  const CollectionDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(collectionModel.title),
        previousPageTitle: AppStrings.toBack,
      ),
      child: FutureBuilder<List<FavoriteDictionaryEntity>>(
        future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
          collectionId: collectionModel.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return CupertinoScrollbar(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final FavoriteDictionaryEntity model = snapshot.data![index];
                  return FavoriteWordItem(model: model, index: index);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorDataText(errorText: snapshot.error.toString());
          } else {
            return const Center(
              child: Padding(
                padding: AppStyles.mainMarding,
                child: Text(
                  AppStrings.favoriteWordsIfEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
