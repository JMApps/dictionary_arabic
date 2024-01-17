import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/core/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';

import '../lists/main_collections_list.dart';

class MainCupertinoPage extends StatefulWidget {
  const MainCupertinoPage({super.key});

  @override
  State<MainCupertinoPage> createState() => _MainCupertinoPageState();
}

class _MainCupertinoPageState extends State<MainCupertinoPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(AppStrings.appName),
        trailing: CupertinoButton(
          onPressed: () {
            // Navigate to settings
          },
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
        ),
      ),
      child: SafeArea(
        right: false,
        left: false,
        child: Column(
          children: [
            Padding(
              padding: AppStyles.mainMardingMini,
              child: CupertinoTextField(
                onTap: () {
                  // To search delegate
                },
                readOnly: true,
                textAlign: TextAlign.center,
                placeholder: AppStrings.searchWords,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Icon(CupertinoIcons.search),
                ),
              ),
            ),
            const Expanded(
              child: MainCollectionsList(collectionCount: 15),
            ),
            CupertinoListSection.insetGrouped(
              backgroundColor: CupertinoColors.systemBackground,
              margin: AppStyles.mardingSymmetricHor,
              decoration: const BoxDecoration(
                color: CupertinoColors.systemFill,
                borderRadius: AppStyles.mainBorderMini,
              ),
              children: [
                CupertinoListTile(
                  onTap: () {},
                  leading: const Icon(CupertinoIcons.collections),
                  trailing: const Icon(CupertinoIcons.forward),
                  title: const Text(AppStrings.allCollection),
                ),
                CupertinoListTile(
                  onTap: () {},
                  leading: const Icon(CupertinoIcons.time),
                  trailing: const Icon(CupertinoIcons.forward),
                  title: const Text(AppStrings.quiz),
                ),
                CupertinoListTile(
                  onTap: () {},
                  leading: const Icon(CupertinoIcons.table_badge_more),
                  trailing: const Icon(CupertinoIcons.forward),
                  title: const Text(AppStrings.wordsConstructor),
                ),
                CupertinoListTile(
                  onTap: () {},
                  leading: const Icon(CupertinoIcons.creditcard),
                  trailing: const Icon(CupertinoIcons.forward),
                  title: const Text(AppStrings.cardMode),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
