import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/collection_args.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../dialogs/change_collection_dialog.dart';
import '../dialogs/delete_all_collections_dialog.dart';
import '../dialogs/delete_collection_dialog.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

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
                builder: (context) => DeleteCollectionDialog(collectionId: collectionModel.id),
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
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.collectionDetailPage,
            arguments: CollectionArgs(collectionModel: collectionModel),
          );
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
              future: Provider.of<CollectionsState>(context, listen: false).getWordCount(collectionId: collectionModel.id),
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
