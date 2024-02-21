import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/services/notifications/local_notice_service.dart';
import '../../../../data/state/app_settings_state.dart';
import '../../../../data/state/word_exact_match_state.dart';
import '../collections/dialogs/add_collection_dialog.dart';
import 'items/main_card_item.dart';
import 'lists/main_collections_list.dart';
import 'widgets/collections_order_button.dart';

class MainMaterialPage extends StatefulWidget {
  const MainMaterialPage({super.key});

  @override
  State<MainMaterialPage> createState() => _MainMaterialPageState();
}

class _MainMaterialPageState extends State<MainMaterialPage> {
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
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final AppSettingsState settings = Provider.of<AppSettingsState>(context);
    LocalNoticeService().dailyZonedScheduleNotification(
      DateTime(2024, 12, 31, settings.getNotificationHours, settings.getNotificationMinutes),
      AppStrings.appName,
      AppStrings.notificationBody,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            forceElevated: true,
            centerTitle: true,
            title: const Text(AppStrings.appName),
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.25,
              titlePadding: const EdgeInsetsDirectional.only(
                start: 0,
                bottom: 8,
              ),
              title: Padding(
                padding: AppStyles.mardingSymmetricHorMini,
                child: CupertinoTextField(
                  padding: AppStyles.horizontalMicroVerticalMicro,
                  placeholder: AppStrings.searchWords,
                  readOnly: true,
                  placeholderStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'SF Pro Regular',
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  decoration: BoxDecoration(
                    color: appColors.primary.withOpacity(0.1),
                    borderRadius: AppStyles.mainBorderMini,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.appSettingsPage);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Consumer<WordExactMatchState>(
              builder: (BuildContext context, matchState, _) {
                return ListTile(
                  contentPadding: AppStyles.mardingSymmetricHor,
                  title: const Text(
                    AppStrings.exactMatch,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SF Pro Regular'
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 0.85,
                    child: Switch(
                      value: matchState.getExactMatch,
                      onChanged: (value) {
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
                          iconName: Icons.quiz,
                          title: AppStrings.quiz,
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.wordConstructorPage,
                          iconName: Icons.table_chart,
                          title: AppStrings.wordsConstructor,
                          color: Colors.green,
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
                          iconName: Icons.filter_frames,
                          title: AppStrings.cards,
                          color: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: MainCardItem(
                          routeName: RouteNames.allCollectionsPage,
                          iconName: Icons.collections_bookmark,
                          title: AppStrings.allCollections,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: ListTile(
              contentPadding: AppStyles.mardingSymmetricHorMini,
              visualDensity: VisualDensity(horizontal: -4),
              title: Text(
                AppStrings.lastCollections,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SF Pro',
                  letterSpacing: 0.15,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              leading: CollectionsOrderButton(),
            ),
          ),
          const MainCollectionsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddCollectionDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
