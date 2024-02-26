import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/collections_state.dart';

class DeleteAllCollectionsDialog extends StatelessWidget {
  const DeleteAllCollectionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Text(
        AppStrings.deletingCollections,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        AppStrings.deleteAllCollectionsQuestion,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            Provider.of<CollectionsState>(context, listen: false).deleteAllCollections();
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
              color: appColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
