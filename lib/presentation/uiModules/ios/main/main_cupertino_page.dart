import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/app_settings_state.dart';
import '../../../../data/state/word_exact_match_state.dart';
import 'items/main_card_item.dart';
import 'lists/main_collections_list.dart';
import 'widgets/add_collection_button.dart';
import 'widgets/collections_order_button.dart';
import 'widgets/main_search_word_text_field.dart';

class MainCupertinoPage extends StatefulWidget {
  const MainCupertinoPage({super.key});

  @override
  State<MainCupertinoPage> createState() => _MainCupertinoPageState();
}

class _MainCupertinoPageState extends State<MainCupertinoPage> {
  @override
  void initState() {
    super.initState();
    _isWordSearch();
  }

  Future<void> _isWordSearch() async {
    if (Provider.of<AppSettingsState>(context, listen: false).getIsSearchWord) {
      await Future.delayed(const Duration(milliseconds: 0)).whenComplete(
          () => Navigator.pushNamed(context, RouteNames.searchWordsPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            middle: const Text(AppStrings.appName),
            largeTitle: const Padding(
              padding: AppStyles.mardingOnlyRight,
              child: MainSearchWordTextField(),
            ),
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.settings),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.appSettingsPage);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Consumer<WordExactMatchState>(
              builder: (BuildContext context, matchState, _) {
                return CupertinoListTile(
                  padding: AppStyles.horizontalVerticalMini,
                  title: const Text(AppStrings.exactMatch),
                  trailing: Transform.scale(
                    scale: 0.75,
                    child: CupertinoSwitch(
                      activeColor: CupertinoColors.systemBlue,
                      value: matchState.getExactMatch,
                      onChanged: (value) {
                        HapticFeedback.lightImpact();
                        matchState.setExactMatch = value;
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: AppStyles.mardingSymmetricHorMini,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.quizPage,
                          iconName: CupertinoIcons.time_solid,
                          title: AppStrings.quiz,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.wordConstructorPage,
                          iconName: CupertinoIcons.table_badge_more_fill,
                          title: AppStrings.wordsConstructor,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.cardModePage,
                          iconName: CupertinoIcons.creditcard_fill,
                          title: AppStrings.cards,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.allCollectionsPage,
                          iconName: CupertinoIcons.collections_solid,
                          title: AppStrings.allCollections,
                          color: CupertinoColors.systemIndigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: CupertinoListTile(
              padding: AppStyles.horizontalVerticalMini,
              title: Text(
                AppStrings.lastCollections,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'SF Pro',
                  letterSpacing: 0.15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CollectionsOrderButton(),
              trailing: AddCollectionButton(),
            ),
          ),
          const MainCollectionsList(),
        ],
      ),
    );
  }
}
