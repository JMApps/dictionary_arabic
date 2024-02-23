import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../dialogs/change_collection_dialog.dart';
import '../dialogs/delete_all_collections_dialog.dart';
import '../dialogs/delete_collection_dialog.dart';

class CollectionOptions extends StatelessWidget {
  const CollectionOptions({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Padding(
      padding: AppStyles.mardingWithoutTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.tonal(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return ChangeCollectionDialog(collectionModel: collectionModel);
                },
              );
            },
            child: const Text(
              AppStrings.change,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteCollectionDialog(collectionId: collectionModel.id);
                },
              );
            },
            child: Text(
              AppStrings.deleteCollection,
              style: TextStyle(
                fontSize: 18,
                color: appColors.error,
              ),
            ),
          ),
          FilledButton.tonal(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) {
                  return const DeleteAllCollectionsDialog();
                },
              );
            },
            child: Text(
              AppStrings.deleteCollections,
              style: TextStyle(
                fontSize: 18,
                color: appColors.error,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
