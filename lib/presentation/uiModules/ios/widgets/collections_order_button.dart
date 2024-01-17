import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';

class CollectionsOrderButton extends StatelessWidget {
  const CollectionsOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context);
    return CupertinoButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoListSection.insetGrouped(
                  header: const Text(AppStrings.orderCollection),
                  backgroundColor: CupertinoColors.systemBackground,
                  margin: AppStyles.mardingSymmetricHor,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemFill,
                    borderRadius: AppStyles.mainBorderMini,
                  ),
                  children: [
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 0;
                      },
                      title: const Text(AppStrings.byAddDateTime),
                      leading: const Icon(CupertinoIcons.time),
                      trailing: collectionsState.getOrderCollectionIndex == 0 ? const Icon(CupertinoIcons.check_mark_circled) : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 1;
                      },
                      title: const Text(AppStrings.byColor),
                      leading: const Icon(CupertinoIcons.color_filter),
                      trailing: collectionsState.getOrderCollectionIndex == 1 ? const Icon(CupertinoIcons.check_mark_circled) : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 2;
                      },
                      title: const Text(AppStrings.byWordsCount),
                      leading: const Icon(CupertinoIcons.square_grid_4x3_fill),
                      trailing: collectionsState.getOrderCollectionIndex == 2 ? const Icon(CupertinoIcons.check_mark_circled) : const SizedBox(),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text(AppStrings.order),
                  footer: const SizedBox(height: 14),
                  backgroundColor: CupertinoColors.systemBackground,
                  margin: AppStyles.mardingSymmetricHor,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemFill,
                    borderRadius: AppStyles.mainBorderMini,
                  ),
                  children: [
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderIndex = 0;
                      },
                      title: const Text(AppStrings.orderASC),
                      leading: const Icon(CupertinoIcons.sort_down),
                      trailing: context.watch<CollectionsState>().getOrderIndex == 0 ? const Icon(CupertinoIcons.check_mark_circled) : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderIndex = 1;
                      },
                      title: const Text(AppStrings.orderDESC),
                      leading: const Icon(CupertinoIcons.sort_up),
                      trailing: context.watch<CollectionsState>().getOrderIndex == 1 ? const Icon(CupertinoIcons.check_mark_circled) : const SizedBox(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.sort_up),
    );
  }
}
