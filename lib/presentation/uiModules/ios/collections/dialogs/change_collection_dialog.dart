import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../data/state/add_change_collection_state.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../widgets/collection_color_circle_button.dart';

class ChangeCollectionDialog extends StatefulWidget {
  const ChangeCollectionDialog({
    super.key,
    required this.model,
  });

  final CollectionEntity model;

  @override
  State<ChangeCollectionDialog> createState() => _ChangeCollectionDialogState();
}

class _ChangeCollectionDialogState extends State<ChangeCollectionDialog> {
  late final TextEditingController _collectionController;

  @override
  void initState() {
    _collectionController = TextEditingController(text: widget.model.title);
    super.initState();
  }

  @override
  void dispose() {
    _collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState =
        Provider.of<CollectionsState>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddChangeCollectionState(widget.model.color),
        ),
      ],
      child: Consumer<AddChangeCollectionState>(
        builder:
            (BuildContext context, AddChangeCollectionState colorState, _) {
          return CupertinoAlertDialog(
            title: const Text(
              AppStrings.changeCollection,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 14),
                CupertinoTextField(
                  controller: _collectionController,
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                  autocorrect: false,
                  maxLength: 100,
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
              CupertinoButton(
                onPressed: () {
                  if (_collectionController.text.trim().isNotEmpty) {
                    final CollectionEntity newModel = CollectionEntity(
                      id: widget.model.id,
                      title: _collectionController.text.trim(),
                      wordsCount: 0,
                      color: colorState.getColorIndex,
                    );
                    if (!widget.model.equals(newModel)) {
                      Navigator.pop(context);
                      collectionsState.changeCollection(model: newModel);
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(AppStrings.change),
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
        },
      ),
    );
  }
}
