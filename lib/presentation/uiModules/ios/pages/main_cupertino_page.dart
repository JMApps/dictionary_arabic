import 'package:arabic/core/routes/route_names.dart';
import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/core/styles/app_styles.dart';
import 'package:arabic/presentation/uiModules/ios/widgets/add_collection_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../lists/main_collections_list.dart';
import '../widgets/collections_order_button.dart';

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
            const Row(
              children: [
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    AppStrings.lastCollections,
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(width: 7),
                CollectionsOrderButton(),
                SizedBox(width: 7),
              ],
            ),
            const MainCollectionsList(shortCollection: true),
            const SizedBox(height: 7),
            CupertinoListSection.insetGrouped(
              backgroundColor: CupertinoColors.systemBackground,
              margin: AppStyles.mardingSymmetricHor,
              decoration: const BoxDecoration(
                color: CupertinoColors.systemFill,
                borderRadius: AppStyles.mainBorderMini,
              ),
              children: [
                CupertinoListTile(
                  padding: AppStyles.mardingSymmetricHor,
                  title: const Text(AppStrings.addCollection),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const AddCollectionDialog();
                      },
                    );
                  },
                  trailing: const Icon(CupertinoIcons.add_circled),
                ),
              ],
            ),
            const SizedBox(height: 7),
            CupertinoListSection.insetGrouped(
              backgroundColor: CupertinoColors.systemBackground,
              margin: AppStyles.mardingSymmetricHor,
              decoration: const BoxDecoration(
                color: CupertinoColors.systemFill,
                borderRadius: AppStyles.mainBorderMini,
              ),
              children: [
                CupertinoListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.allCollectionsPage);
                  },
                  leading: const Icon(CupertinoIcons.collections),
                  trailing: const Icon(CupertinoIcons.forward),
                  title: const Text(AppStrings.allCollections),
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
