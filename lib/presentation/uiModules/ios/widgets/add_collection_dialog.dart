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
    return CupertinoListSection.insetGrouped(
      backgroundColor: CupertinoColors.systemBackground,
      margin: AppStyles.mardingSymmetricHor,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemFill,
        borderRadius: AppStyles.mainBorderMini,
      ),
      children: [
        CupertinoListTile(
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
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
            );
          },
          title: const Text(AppStrings.addCollection),
          trailing: const Icon(CupertinoIcons.add_circled),
        ),
      ],
    );
  }
}
