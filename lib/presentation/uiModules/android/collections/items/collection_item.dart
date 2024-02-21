import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/collection_args.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../widget/collection_options.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.collectionModel,
    required this.index,
  });

  final CollectionEntity collectionModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.inversePrimary.withOpacity(0.05);
    final Color itemEvenColor = appColors.inversePrimary.withOpacity(0.15);
    return Container(
      margin: AppStyles.mainMardingMini,
      child: ListTile(
        contentPadding: AppStyles.mardingSymmetricHor,
        shape: AppStyles.mainShapeMini,
        visualDensity: const VisualDensity(vertical: -4),
        tileColor: index.isOdd ? itemOddColor : itemEvenColor,
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.collectionDetailPage,
            arguments: CollectionArgs(collectionModel: collectionModel),
          );
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CollectionOptions(collectionModel: collectionModel),
          );
        },
        title: Text(
          collectionModel.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        leading: Icon(
          Icons.folder,
          color: AppStyles.collectionColors[collectionModel.color],
        ),
        trailing: Consumer<FavoriteWordsState>(
          builder: (BuildContext context, FavoriteWordsState value, _) {
            return FutureBuilder<int>(
              future: Provider.of<CollectionsState>(context, listen: false).getWordCount(collectionId: collectionModel.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
