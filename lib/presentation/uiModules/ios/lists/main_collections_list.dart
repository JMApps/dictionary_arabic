import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/core/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../items/collection_item.dart';
import '../widgets/error_data_text.dart';

class MainCollectionsList extends StatefulWidget {
  const MainCollectionsList({super.key, required this.shortCollection});

  final bool shortCollection;

  @override
  State<MainCollectionsList> createState() => _MainCollectionsListState();
}

class _MainCollectionsListState extends State<MainCollectionsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CollectionsState>(
      builder: (BuildContext context, CollectionsState collectionsState, _) {
        return Expanded(
          child: FutureBuilder<List<CollectionEntity>>(
            // Добавить методы сортировки
            future: collectionsState.fetchAllCollections(),
            builder: (BuildContext context, AsyncSnapshot<List<CollectionEntity>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return CupertinoScrollbar(
                  child: ListView.builder(
                    itemCount: widget.shortCollection && snapshot.data!.length > 15 ? 15 : snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CollectionEntity model = snapshot.data![index];
                      return CollectionItem(
                        model: model,
                        index: index,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorDataText(
                  errorText: snapshot.error.toString(),
                );
              } else {
                return const Center(
                  child: Padding(
                    padding: AppStyles.mainMarding,
                    child: Text(
                      AppStrings.collectionsIfEmpty,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
