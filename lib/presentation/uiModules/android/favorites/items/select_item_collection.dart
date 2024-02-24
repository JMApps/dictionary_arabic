import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../collections/widget/collection_options.dart';

class SelectItemCollection extends StatelessWidget{
  const SelectItemCollection({
    super.key,
    required this.wordModel,
    required this.serializableIndex,
    required this.collectionModel,
    required this.index,
  });

  final DictionaryEntity wordModel;
  final int serializableIndex;
  final CollectionEntity collectionModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.inversePrimary.withOpacity(0.05);
    final Color itemEvenColor = appColors.inversePrimary.withOpacity(0.15);
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
          final favoriteWordModel = FavoriteDictionaryEntity(
            articleId: wordModel.articleId,
            translation: wordModel.translation,
            arabic: wordModel.arabic,
            id: wordModel.id,
            wordNumber: wordModel.wordNumber,
            arabicWord: wordModel.arabicWord,
            form: wordModel.form,
            additional: wordModel.additional,
            vocalization: wordModel.vocalization,
            homonymNr: wordModel.homonymNr,
            root: wordModel.root,
            forms: wordModel.forms,
            collectionId: collectionModel.id,
            serializableIndex: serializableIndex,
            ankiCount: 0,
          );
          await Provider.of<FavoriteWordsState>(context, listen: false).addFavoriteWord(model: favoriteWordModel);
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CollectionOptions(collectionModel: collectionModel),
          );
        },
        title: Text(
          collectionModel.title,
          style: const TextStyle(
            fontSize: 18,
          ),
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
                style: const TextStyle(
                  fontSize: 18,
                ),
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
  }
}
