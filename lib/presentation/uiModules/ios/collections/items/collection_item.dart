import 'package:arabic/data/state/collections_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/args/collection_args.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../dialogs/change_collection_dialog.dart';
import '../dialogs/delete_all_collections_dialog.dart';
import '../dialogs/delete_collection_dialog.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.model,
    required this.index,
  });

  final CollectionEntity model;
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
                builder: (context) => ChangeCollectionDialog(model: model),
              );
            },
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.pen,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => DeleteCollectionDialog(collectionId: model.id),
              );
            },
            backgroundColor: CupertinoColors.systemIndigo,
            icon: CupertinoIcons.delete_simple,
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
            arguments: CollectionArgs(collectionEntity: model),
          );
        },
        title: Text(
          model.title,
          style: const TextStyle(fontSize: 20),
        ),
        leading: Icon(
          CupertinoIcons.tag_solid,
          color: AppStyles.collectionColors[model.color],
        ),
        trailing: const Icon(
          CupertinoIcons.chevron_forward,
          color: CupertinoColors.systemGrey,
        ),
        additionalInfo: FutureBuilder<int>(
          future: Provider.of<CollectionsState>(context, listen: false).getWordCount(collectionId: model.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.toString(),
              );
            } else {
              return const Text('0');
            }
          }
        ),
      ),
    );
  }
}
