import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../widgets/data_text.dart';
import '../../widgets/error_data_text.dart';
import '../items/main_collection_item.dart';
import '../widgets/add_collection_button.dart';

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
                CupertinoListSection.insetGrouped(
                  margin: AppStyles.mardingSymmetricHor,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length >= 11 ? 11 : snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CollectionEntity model = snapshot.data![index];
                        return MainCollectionItem(wordModel: model);
                      },
                    ),
                  ],
                ),
                snapshot.data!.length >= 11
                    ? Padding(
                        padding: AppStyles.mainMarding,
                        child: CupertinoButton(
                          color: CupertinoColors.systemBlue,
                          onPressed: () {
                            Navigator.pushNamed(context, RouteNames.allCollectionsPage);
                          },
                          child: const Text(AppStrings.allCollections),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DataText(text: AppStrings.createCollectionsWithWords),
                const SizedBox(height: 7),
                Transform.scale(
                  scale: 2,
                  child: const AddCollectionButton(),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorDataText(errorText: snapshot.error.toString()),
          );
        } else {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
