import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
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
                  margin: AppStyles.mardingSymmetricHor,
                  decoration: const BoxDecoration(
                    borderRadius: AppStyles.mainBorderMini,
                    color: CupertinoColors.quaternarySystemFill,
                  ),
                  children: [
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 0;
                      },
                      title: const Text(AppStrings.byAddDateTime),
                      leading: const Icon(CupertinoIcons.time_solid),
                      trailing: collectionsState.getOrderCollectionIndex == 0
                          ? const Icon(CupertinoIcons.checkmark_circle_fill)
                          : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 1;
                      },
                      title: const Text(AppStrings.byColor),
                      leading: const Icon(CupertinoIcons.circle_fill),
                      trailing: collectionsState.getOrderCollectionIndex == 1
                          ? const Icon(CupertinoIcons.checkmark_circle_fill)
                          : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderCollectionIndex = 2;
                      },
                      title: const Text(AppStrings.byWordsCount),
                      leading: const Icon(CupertinoIcons.square_grid_4x3_fill),
                      trailing: collectionsState.getOrderCollectionIndex == 2
                          ? const Icon(CupertinoIcons.checkmark_circle_fill)
                          : const SizedBox(),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text(AppStrings.order),
                  footer: const SizedBox(height: 14),
                  margin: AppStyles.mardingSymmetricHor,
                  decoration: const BoxDecoration(
                    borderRadius: AppStyles.mainBorderMini,
                    color: CupertinoColors.quaternarySystemFill,
                  ),
                  children: [
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderIndex = 0;
                      },
                      title: const Text(AppStrings.orderASC),
                      leading: const Icon(CupertinoIcons.sort_down_circle_fill),
                      trailing:
                          context.watch<CollectionsState>().getOrderIndex == 0
                              ? const Icon(CupertinoIcons.checkmark_circle_fill)
                              : const SizedBox(),
                    ),
                    CupertinoListTile(
                      onTap: () {
                        collectionsState.setOrderIndex = 1;
                      },
                      title: const Text(AppStrings.orderDESC),
                      leading: const Icon(CupertinoIcons.sort_up_circle_fill),
                      trailing:
                          context.watch<CollectionsState>().getOrderIndex == 1
                              ? const Icon(CupertinoIcons.checkmark_circle_fill)
                              : const SizedBox(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      padding: EdgeInsets.zero,
      child: const Icon(
        CupertinoIcons.sort_up_circle_fill,
        size: 32.5,
      ),
    );
  }
}
