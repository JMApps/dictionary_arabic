import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';

class CollectionsOrderButton extends StatelessWidget {
  const CollectionsOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionsState>(
      builder: (BuildContext context, collectionsState, _) {
        return CupertinoButton(
          padding: AppStyles.mardingOnlyLeftMini,
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoListSection.insetGrouped(
                      header: const Text(AppStrings.orderCollection),
                      margin: AppStyles.mardingWithoutBottomMini,
                      decoration: const BoxDecoration(
                        borderRadius: AppStyles.mainBorderMini,
                        color: CupertinoColors.quaternarySystemFill,
                      ),
                      children: [
                        CupertinoListTile(
                          onTap: () => collectionsState.setOrderCollectionIndex = 0,
                          title: const Text(AppStrings.byAddDateTime),
                          trailing: collectionsState.getOrderCollectionIndex == 0
                              ? const Icon(CupertinoIcons.checkmark_alt)
                              : const SizedBox(),
                        ),
                        CupertinoListTile(
                          onTap: () => collectionsState.setOrderCollectionIndex = 1,
                          title: const Text(AppStrings.byColor),
                          trailing: collectionsState.getOrderCollectionIndex == 1
                              ? const Icon(CupertinoIcons.checkmark_alt)
                              : const SizedBox(),
                        ),
                        CupertinoListTile(
                          onTap: () => collectionsState.setOrderCollectionIndex = 2,
                          title: const Text(AppStrings.byWordsCount),
                          trailing: collectionsState.getOrderCollectionIndex == 2
                              ? const Icon(CupertinoIcons.checkmark_alt)
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    CupertinoListSection.insetGrouped(
                      header: const Text(AppStrings.order),
                      footer: const SizedBox(height: 14),
                      margin: AppStyles.mardingWithoutBottomMini,
                      decoration: const BoxDecoration(
                        borderRadius: AppStyles.mainBorderMini,
                        color: CupertinoColors.quaternarySystemFill,
                      ),
                      children: [
                        CupertinoListTile(
                          onTap: () => collectionsState.setOrderIndex = 1,
                          title: const Text(AppStrings.orderASC),
                          trailing: context.watch<CollectionsState>().getOrderIndex == 1
                              ? const Icon(CupertinoIcons.checkmark_alt)
                              : const SizedBox(),
                        ),
                        CupertinoListTile(
                          onTap: () => collectionsState.setOrderIndex = 0,
                          title: const Text(AppStrings.orderDESC),
                          trailing: collectionsState.getOrderIndex == 0
                              ? const Icon(CupertinoIcons.checkmark_alt)
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            CupertinoIcons.arrow_up_arrow_down_circle_fill,
            size: 32.5,
          ),
        );
      },
    );
  }
}
