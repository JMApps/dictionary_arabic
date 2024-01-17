import 'package:arabic/core/styles/app_styles.dart';
import 'package:arabic/data/state/collections_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../items/collection_item.dart';
import '../widgets/add_collection_dialog.dart';
import '../widgets/error_data_text.dart';

class AllCollectionsPage extends StatelessWidget {
  const AllCollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context);
    return CupertinoPageScaffold(
      child: FutureBuilder<List<CollectionEntity>>(
        future: collectionsState.fetchAllCollections(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  middle: const Text(AppStrings.allCollections),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(CupertinoIcons.add_circled),
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return const AddCollectionDialog();
                        },
                      );
                    },
                  ),
                  previousPageTitle: AppStrings.main,
                  largeTitle: CupertinoTextField(
                    onTap: () {
                      // To search delegate
                    },
                    readOnly: true,
                    textAlign: TextAlign.center,
                    placeholder: AppStrings.searchCollections,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Icon(CupertinoIcons.search),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final CollectionEntity model = snapshot.data![index];
                    return CollectionItem(
                      model: model,
                      index: index,
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorDataText(errorText: snapshot.error.toString());
          } else {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: const Text(AppStrings.allCollections),
                previousPageTitle: AppStrings.main,
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.add_circled),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return const AddCollectionDialog();
                      },
                    );
                  },
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: AppStyles.mainMarding,
                  child: Text(
                    AppStrings.collectionsIfEmpty,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
