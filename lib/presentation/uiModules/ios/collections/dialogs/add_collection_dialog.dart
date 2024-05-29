import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/add_change_collection_state.dart';
import '../../../../../data/state/collections_state.dart';
import '../widgets/collection_color_circle_button.dart';

class AddCollectionDialog extends StatefulWidget {
  const AddCollectionDialog({super.key});

  @override
  State<AddCollectionDialog> createState() => _AddCollectionDialogState();
}

class _AddCollectionDialogState extends State<AddCollectionDialog> {
  final TextEditingController _collectionController = TextEditingController();

  @override
  void dispose() {
    _collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddChangeCollectionState(0),
        ),
      ],
      child: CupertinoAlertDialog(
        title: const Text(
          AppStrings.newCollection,
          style: TextStyle(fontSize: 20),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 14),
            CupertinoTextField(
              controller: _collectionController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.center,
              placeholder: AppStrings.title,
              placeholderStyle: const TextStyle(
                color: CupertinoColors.placeholderText,
                fontSize: 20,
                fontFamily: 'SF Pro',
              ),
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'SF Pro',
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
            builder: (BuildContext context, colorState, _) {
              return CupertinoButton(
                onPressed: () async {
                  if (_collectionController.text.trim().isNotEmpty) {
                    Navigator.pop(context);
                    final Map<String, dynamic> mapCollection = {
                      'title': _collectionController.text.trim(),
                      'words_count': 0,
                      'color': colorState.getColorIndex,
                    };
                    await Provider.of<CollectionsState>(context, listen: false).addCollection(mapCollection: mapCollection);
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
              style: TextStyle(color: CupertinoColors.systemRed),
            ),
          ),
        ],
      ),
    );
  }
}
