import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/collections_state.dart';

class DeleteCollectionDialog extends StatelessWidget {
  const DeleteCollectionDialog({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState =
        Provider.of<CollectionsState>(context);
    return CupertinoAlertDialog(
      title: const Text(AppStrings.deletingCollection),
      content: const Text(AppStrings.deleteCollectionQuestion),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            collectionsState.deleteCollection(collectionId: collectionId);
          },
          child: const Text(AppStrings.delete),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            AppStrings.cancel,
            style: TextStyle(
              color: CupertinoColors.systemRed,
            ),
          ),
        ),
      ],
    );
  }
}
