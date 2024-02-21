import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/add_change_collection_state.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../widget/collection_color_circle_button.dart';

class ChangeCollectionDialog extends StatefulWidget {
  const ChangeCollectionDialog({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<ChangeCollectionDialog> createState() => _ChangeCollectionDialogState();
}

class _ChangeCollectionDialogState extends State<ChangeCollectionDialog> {
  late final TextEditingController _collectionController;

  @override
  void initState() {
    _collectionController = TextEditingController(text: widget.collectionModel.title);
    super.initState();
  }

  @override
  void dispose() {
    _collectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddChangeCollectionState(widget.collectionModel.color),
        ),
      ],
      child: Consumer<AddChangeCollectionState>(
        builder: (BuildContext context, colorState, _) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            title: const Text(
              AppStrings.changeCollection,
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
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                  maxLength: 100,
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
                const SizedBox(height: 8),
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
              OutlinedButton(
                onPressed: () {
                  if (_collectionController.text.trim().isNotEmpty) {
                    final CollectionEntity newModel = CollectionEntity(
                      id: widget.collectionModel.id,
                      title: _collectionController.text.trim(),
                      wordsCount: 0,
                      color: colorState.getColorIndex,
                    );
                    if (!widget.collectionModel.equals(newModel)) {
                      Navigator.pop(context);
                      collectionsState.changeCollection(model: newModel);
                    } else {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  AppStrings.change,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  AppStrings.cancel,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
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
