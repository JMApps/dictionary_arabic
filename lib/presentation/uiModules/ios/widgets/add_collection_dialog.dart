import 'package:arabic/presentation/uiModules/ios/widgets/collection_color_circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';

class AddCollectionDialog extends StatefulWidget {
  const AddCollectionDialog({super.key});

  @override
  State<AddCollectionDialog> createState() => _AddCollectionDialogState();
}

class _AddCollectionDialogState extends State<AddCollectionDialog> {
  final TextEditingController _collectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context);
    return CupertinoAlertDialog(
      title: const Text(AppStrings.addCollection),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 14),
          CupertinoTextField(
            controller: _collectionController,
            autofocus: true,
            maxLength: 100,
            placeholder: AppStrings.collectionTitle,
            clearButtonMode: OverlayVisibilityMode.editing,
          ),
          const SizedBox(height: 14),
          const Wrap(
            alignment: WrapAlignment.center,
            children: [
              CollectionColorCircleButton(buttonIndex: 0),
              CollectionColorCircleButton(buttonIndex: 1),
              CollectionColorCircleButton(buttonIndex: 2),
              CollectionColorCircleButton(buttonIndex: 3),
              CollectionColorCircleButton(buttonIndex: 4),
              CollectionColorCircleButton(buttonIndex: 5),
              CollectionColorCircleButton(buttonIndex: 6),
              CollectionColorCircleButton(buttonIndex: 7),
            ],
          ),
        ],
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            if (_collectionController.text.trim().isNotEmpty) {
              Navigator.pop(context);
              final CollectionEntity model = CollectionEntity(
                id: 0,
                title: _collectionController.text.trim(),
                wordsCount: 0,
                color: collectionsState.getColorIndex,
              );
              collectionsState.addCollection(model: model);
              collectionsState.setColorIndex = 0;
              _collectionController.clear();
            }
          },
          child: const Text(AppStrings.add),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
            collectionsState.setColorIndex = 0;
            _collectionController.clear();
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
