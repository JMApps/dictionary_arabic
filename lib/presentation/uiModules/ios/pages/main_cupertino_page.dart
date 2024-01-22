import 'package:flutter/cupertino.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../items/main_card_item.dart';
import '../lists/main_collections_list.dart';
import '../widgets/add_collection_button.dart';
import '../widgets/collections_order_button.dart';
import '../widgets/main_search_word_text_field.dart';

class MainCupertinoPage extends StatelessWidget {
  const MainCupertinoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            middle: Text(
              AppStrings.appName,
            ),
            largeTitle: Padding(
              padding: AppStyles.mardingOnlyRight,
              child: MainSearchWordTextField(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 14),
                Row(
                  children: [
                    SizedBox(width: 14),
                    Expanded(
                      child: MainCardItem(
                        routeName: RouteNames.allCollectionsPage,
                        iconName: CupertinoIcons.time_solid,
                        title: AppStrings.quiz,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: MainCardItem(
                        routeName: RouteNames.allCollectionsPage,
                        iconName: CupertinoIcons.table_badge_more_fill,
                        title: AppStrings.wordsConstructor,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                    SizedBox(width: 14),
                  ],
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    SizedBox(width: 14),
                    Expanded(
                      child: MainCardItem(
                        routeName: RouteNames.allCollectionsPage,
                        iconName: CupertinoIcons.creditcard_fill,
                        title: AppStrings.cardMode,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: MainCardItem(
                        routeName: RouteNames.allCollectionsPage,
                        iconName: CupertinoIcons.collections_solid,
                        title: AppStrings.allCollections,
                        color: CupertinoColors.systemIndigo,
                      ),
                    ),
                    SizedBox(width: 14),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListTile(
              padding: AppStyles.mainMarding,
              title: Text(
                AppStrings.lastCollections,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 22,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.start,
              ),
              leading: CollectionsOrderButton(),
              trailing: AddCollectionButton(),
            ),
          ),
          SliverToBoxAdapter(
            child: MainCollectionsList(shortCollection: true),
          ),
        ],
      ),
    );
  }
}
