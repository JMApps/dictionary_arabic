import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../collections/items/collection_item.dart';
import '../../widgets/data_text.dart';
import '../../widgets/error_data_text.dart';

class MainCollectionsList extends StatelessWidget {
  const MainCollectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CollectionEntity>>(
      future: Provider.of<CollectionsState>(context).fetchAllCollections(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CupertinoListSection.insetGrouped(
                margin: AppStyles.mardingSymmetricHorMini,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.length > 15 ? 15 : snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CollectionEntity model = snapshot.data![index];
                      return CollectionItem(model: model, index: index);
                    },
                  ),
                ],
              ),
              snapshot.data!.length > 15
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
