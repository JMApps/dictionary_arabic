import 'package:flutter/cupertino.dart';
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
    return CupertinoAlertDialog(
      title: const Text(
        AppStrings.deletingCollection,
        style: TextStyle(fontSize: 20),
      ),
      content: const Text(AppStrings.deleteCollectionQuestion,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'SF Pro Regular',
        ),
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<CollectionsState>(context, listen: false).deleteCollection(collectionId: collectionId);
          },
          child: const Text(
            AppStrings.delete,
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(AppStrings.cancel),
        ),
      ],
    );
  }
}
