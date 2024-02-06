import 'package:arabic/core/routes/route_names.dart';
import 'package:arabic/domain/entities/args/collection_args.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';

class CardModePage extends StatelessWidget {
  const CardModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            stretch: true,
            alwaysShowMiddle: false,
            middle: const Text(AppStrings.cardMode),
            previousPageTitle: AppStrings.main,
            largeTitle: const Text(AppStrings.selectCollection),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    title: const Text(
                      AppStrings.warning,
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.systemRed,
                      ),
                    ),
                    content:
                        const DataText(text: AppStrings.cardCollectionsInfo),
                    actions: [
                      CupertinoButton(
                        child: const Text(AppStrings.itsClear),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(CupertinoIcons.info),
            ),
          ),
          FutureBuilder<List<CollectionEntity>>(
            future:
                Provider.of<CollectionsState>(context).fetchAllCollections(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: CupertinoListSection.insetGrouped(
                    margin: AppStyles.mardingWithoutBottomMini,
                    footer: const SizedBox(height: 14),
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final CollectionEntity model = snapshot.data![index];
                          return CupertinoListTile(
                            title: Text(model.title),
                            trailing: const Icon(CupertinoIcons.forward),
                            additionalInfo: Text(model.wordsCount.toString()),
                            onTap: model.wordsCount >= 5
                                ? () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.cardsCollectionPage,
                                      arguments: CollectionArgs(
                                        collectionEntity: model,
                                      ),
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: ErrorDataText(
                    errorText: snapshot.error.toString(),
                  ),
                );
              } else {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: DataText(text: AppStrings.cardCollectionsIfEmpty),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
