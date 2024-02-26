import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/args/collection_args.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';

class CardModePage extends StatelessWidget {
  const CardModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.15);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appColors.inversePrimary,
            forceElevated: true,
            centerTitle: true,
            floating: true,
            title: const Text(AppStrings.cardMode),
          ),
          FutureBuilder<List<CollectionEntity>>(
            future: Provider.of<CollectionsState>(context, listen: false).fetchAllCollections(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: ListView.builder(
                    padding: AppStyles.mardingWithoutBottom,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CollectionEntity collectionModel = snapshot.data![index];
                      return Container(
                        margin: AppStyles.mardingOnlyBottom,
                        child: ListTile(
                          contentPadding: AppStyles.mardingSymmetricHor,
                          shape: AppStyles.mainShapeMini,
                          visualDensity: VisualDensity.compact,
                          tileColor: index.isOdd ? itemOddColor : itemEvenColor,
                          leading: Icon(
                            Icons.folder,
                            color: AppStyles.collectionColors[collectionModel.color],
                          ),
                          trailing: Text(
                            collectionModel.wordsCount.toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          title: Text(
                            collectionModel.title,
                            style: const TextStyle(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: collectionModel.wordsCount >= 1
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.cardsModeDetailPage,
                                    arguments: CollectionArgs(
                                      collectionModel: collectionModel,
                                    ),
                                  );
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: ErrorDataText(errorText: snapshot.error.toString()),
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
