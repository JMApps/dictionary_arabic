import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/add_change_collection_state.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../widgets/collection_color_circle_button.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddChangeCollectionState(0),
        ),
      ],
      child: CupertinoAlertDialog(
        title: const Text(AppStrings.newCollection),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 14),
            CupertinoTextField(
              textCapitalization: TextCapitalization.words,
              controller: _collectionController,
              autofocus: true,
              autocorrect: false,
              maxLength: 100,
              textAlign: TextAlign.center,
              placeholder: AppStrings.title,
              placeholderStyle: const TextStyle(
                color: CupertinoColors.placeholderText,
                fontFamily: 'SF Pro',
                letterSpacing: 0.75,
              ),
              style: const TextStyle(
                fontFamily: 'SF Pro',
                letterSpacing: 0.75,
              ),
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
          Consumer<AddChangeCollectionState>(
            builder: (BuildContext context, AddChangeCollectionState colorState, _) {
              return CupertinoButton(
                onPressed: () async {
                  if (_collectionController.text.trim().isNotEmpty) {
                    Navigator.pop(context);
                    final CollectionEntity model = CollectionEntity(
                      id: 0,
                      title: _collectionController.text.trim(),
                      wordsCount: 0,
                      color: colorState.getColorIndex,
                    );
                    await collectionsState.addCollection(model: model);
                  }
                },
                child: const Text(AppStrings.add),
              );
            },
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
      ),
    );
  }
}
