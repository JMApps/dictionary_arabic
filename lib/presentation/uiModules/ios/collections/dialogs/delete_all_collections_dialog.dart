import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/collections_state.dart';

class DeleteAllCollectionsDialog extends StatelessWidget {
  const DeleteAllCollectionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        AppStrings.deletingCollections,
        style: TextStyle(fontSize: 20),
      ),
      content: const Text(AppStrings.deleteAllCollectionsQuestion,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'SF Pro Regular',
        ),
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<CollectionsState>(context, listen: false).deleteAllCollections();
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
