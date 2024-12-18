import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/add_change_collection_state.dart';
import '../../../../../data/state/collections_state.dart';
import '../widget/collection_color_circle_button.dart';

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
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddChangeCollectionState(0),
        ),
      ],
      child: AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: const Text(
          AppStrings.newCollection,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _collectionController,
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: AppStyles.mardingSymmetricHorMini,
                border: const OutlineInputBorder(
                  borderRadius: AppStyles.mainBorder,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _collectionController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                hintText: AppStrings.title,
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'SF Pro',
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 24),
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
              return OutlinedButton(
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
                child: Text(
                  AppStrings.add,
                  style: TextStyle(
                    fontSize: 18,
                    color: appColors.primary,
                  ),
                ),
              );
            },
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                fontSize: 18,
                color: appColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
