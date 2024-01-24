import 'package:arabic/presentation/uiModules/ios/widgets/data_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../items/collection_item.dart';
import '../widgets/error_data_text.dart';

class MainCollectionsList extends StatelessWidget {
  const MainCollectionsList({super.key, required this.shortCollection});

  final bool shortCollection;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollectionEntity>>(
      future: Provider.of<CollectionsState>(context).fetchAllCollections(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return CupertinoListSection.insetGrouped(
            margin: AppStyles.mardingSymmetricHor,
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: shortCollection && snapshot.data!.length > 15 ? 15 : snapshot.data!.length,
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
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const DataText(text: AppStrings.createCollectionsWithWords);
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
