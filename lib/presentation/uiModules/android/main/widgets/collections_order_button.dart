import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';

class CollectionsOrderButton extends StatelessWidget {
  const CollectionsOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context);
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: AppStyles.mardingWithoutTop,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    AppStrings.orderCollection,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: () => collectionsState.setOrderCollectionIndex = 0,
                        shape: AppStyles.mainShapeMini,
                        title: const Text(AppStrings.byAddDateTime),
                        leading: const Icon(Icons.sort),
                        trailing: collectionsState.getOrderCollectionIndex == 0
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                      ),
                      ListTile(
                        onTap: () => collectionsState.setOrderCollectionIndex = 1,
                        shape: AppStyles.mainShapeMini,
                        title: const Text(AppStrings.byColor),
                        leading: const Icon(Icons.sort),
                        trailing: collectionsState.getOrderCollectionIndex == 1
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                      ),
                      ListTile(
                        onTap: () => collectionsState.setOrderCollectionIndex = 2,
                        shape: AppStyles.mainShapeMini,
                        title: const Text(AppStrings.byWordsCount),
                        leading: const Icon(Icons.sort),
                        trailing: collectionsState.getOrderCollectionIndex == 2
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const Text(
                    AppStrings.order,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: () => collectionsState.setOrderIndex = 1,
                        shape: AppStyles.mainShapeMini,
                        title: const Text(AppStrings.orderASC),
                        leading: const Icon(Icons.sort),
                        trailing: context.watch<CollectionsState>().getOrderIndex == 1
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                      ),
                      ListTile(
                        onTap: () => collectionsState.setOrderIndex = 0,
                        shape: AppStyles.mainShapeMini,
                        title: const Text(AppStrings.orderDESC),
                        leading: const Icon(Icons.sort),
                        trailing: collectionsState.getOrderIndex == 0
                            ? const Icon(Icons.check)
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      icon: Icon(
        Icons.sort,
        color: appColors.primary,
      ),
    );
  }
}
