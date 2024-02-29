import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../collections/dialogs/change_collection_dialog.dart';
import '../../collections/dialogs/delete_all_collections_dialog.dart';
import '../../collections/dialogs/delete_collection_dialog.dart';

class SelectItemCollection extends StatelessWidget {
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
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => ChangeCollectionDialog(collectionModel: collectionModel),
              );
            },
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.pen,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => DeleteCollectionDialog(collectionId: wordModel.id),
              );
            },
            backgroundColor: CupertinoColors.systemIndigo,
            icon: CupertinoIcons.delete,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => const DeleteAllCollectionsDialog(),
              );
            },
            backgroundColor: CupertinoColors.systemRed,
            icon: CupertinoIcons.delete_solid,
          ),
        ],
      ),
      child: CupertinoListTile(
        padding: AppStyles.mardingSymmetricHorMini,
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
        title: Text(
          collectionModel.title,
          style: const TextStyle(fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Icon(
          CupertinoIcons.folder_fill,
          color: AppStyles.collectionColors[collectionModel.color],
        ),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
          color: CupertinoColors.systemGrey,
        ),
        additionalInfo: Consumer<FavoriteWordsState>(
          builder: (BuildContext context, _, __) {
            return FutureBuilder<int>(
              future: Provider.of<CollectionsState>(context).getWordCount(collectionId: collectionModel.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(fontSize: 20),
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
