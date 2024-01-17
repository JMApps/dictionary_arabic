import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';

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
    Provider.of<CollectionsState>(context, listen: false).setColorIndex = widget.model.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context, listen: false);
    return CupertinoAlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoTextField(
            controller: _collectionController,
            autofocus: true,
            maxLength: 100,
            placeholder: AppStrings.collectionTitle,
            clearButtonMode: OverlayVisibilityMode.editing,
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              height: 14,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: AppStyles.collectionColors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      collectionsState.setColorIndex = index;
                    },
                    child: Icon(
                      context.watch<CollectionsState>().getColorIndex == index
                          ? CupertinoIcons.checkmark_circle_fill
                          : CupertinoIcons.circle_fill,
                      color: AppStyles.collectionColors[index],
                    ),
                  );
                },
              ),
            ),
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
                color: collectionsState.getColorIndex,
              );
              if (!widget.model.equals(newModel)) {
                collectionsState.changeCollection(model: newModel);
                collectionsState.setColorIndex = 0;
                _collectionController.clear();
                Navigator.pop(context);
              } else {
                collectionsState.setColorIndex = 0;
                _collectionController.clear();
                Navigator.pop(context);
              }
            }
          },
          child: const Text(AppStrings.change),
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
