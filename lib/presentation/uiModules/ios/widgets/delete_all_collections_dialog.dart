import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/collections_state.dart';

class DeleteAllCollectionsDialog extends StatelessWidget {
  const DeleteAllCollectionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context, listen: false);
    return CupertinoAlertDialog(
      title: const Text(AppStrings.deletingCollections),
      content: const Text(AppStrings.deleteAllCollectionsQuestion),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            collectionsState.deleteAllCollections();
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
