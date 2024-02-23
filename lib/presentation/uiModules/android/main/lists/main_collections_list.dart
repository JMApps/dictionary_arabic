import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../widgets/data_text.dart';
import '../../widgets/error_data_text.dart';
import '../items/main_collection_item.dart';

class MainCollectionsList extends StatelessWidget {
  const MainCollectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollectionEntity>>(
      future: Provider.of<CollectionsState>(context).fetchAllCollections(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length >= 11 ? 11 : snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final CollectionEntity model = snapshot.data![index];
                    return MainCollectionItem(
                      collectionModel: model,
                      index: index,
                    );
                  },
                ),
                snapshot.data!.length >= 11
                    ? Padding(
                        padding: AppStyles.mardingWithoutTop,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.allCollectionsPage);
                          },
                          child: const Text(
                            AppStrings.allCollections,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ) : const SizedBox(),
              ],
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: DataText(text: AppStrings.createCollectionsWithWords),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorDataText(errorText: snapshot.error.toString()),
          );
        } else {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
