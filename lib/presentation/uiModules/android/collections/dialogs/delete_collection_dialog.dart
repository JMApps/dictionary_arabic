import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/collections_state.dart';

class DeleteCollectionDialog extends StatelessWidget {
  const DeleteCollectionDialog({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text(
        AppStrings.deletingCollection,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        AppStrings.deleteCollectionQuestion,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<CollectionsState>(context, listen: false).deleteCollection(collectionId: collectionId);
          },
          child: Text(
            AppStrings.delete,
            style: TextStyle(
              fontSize: 18,
              color: appColors.error,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel,
            style: TextStyle(
              fontSize: 18,
              color: appColors.primary
            ),
          ),
        ),
      ],
    );
  }
}
