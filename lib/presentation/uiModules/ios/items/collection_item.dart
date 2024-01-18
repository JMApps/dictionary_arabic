import 'package:arabic/core/styles/app_styles.dart';
import 'package:arabic/presentation/uiModules/ios/widgets/delete_all_collections_dialog.dart';
import 'package:arabic/presentation/uiModules/ios/widgets/delete_collection_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../domain/entities/collection_entity.dart';
import '../widgets/change_collection_dialog.dart';

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
            backgroundColor: CupertinoColors.systemGreen,
            foregroundColor: CupertinoColors.systemBackground,
            icon: CupertinoIcons.pencil,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => DeleteCollectionDialog(collectionId: model.id),
              );
            },
            backgroundColor: CupertinoColors.systemRed,
            foregroundColor: CupertinoColors.systemBackground,
            icon: CupertinoIcons.delete_solid,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) => const DeleteAllCollectionsDialog(),
              );
            },
            backgroundColor: CupertinoColors.systemBlue,
            foregroundColor: CupertinoColors.systemBackground,
            icon: CupertinoIcons.delete_solid,
          ),
        ],
      ),
      child: CupertinoListTile(
        onTap: () {
          // Navigate to collection page
        },
        title: Text(model.title),
        leading: Icon(
          CupertinoIcons.tags_solid,
          color: AppStyles.collectionColors[model.color],
        ),
        trailing: const Icon(
          CupertinoIcons.forward,
          color: CupertinoColors.systemGrey2,
        ),
        additionalInfo: Text(model.wordsCount.toString()),
      ),
    );
  }
}
