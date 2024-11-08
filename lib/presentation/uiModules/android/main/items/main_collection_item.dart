import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/collection_args.dart';
import '../../../../../domain/entities/collection_entity.dart';
import '../../collections/widget/collection_options.dart';

class MainCollectionItem extends StatelessWidget {
  const MainCollectionItem({
    super.key,
    required this.collectionModel,
    required this.index,
  });

  final CollectionEntity collectionModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
    return Container(
      margin: AppStyles.mardingWithoutTop,
      child: ListTile(
        contentPadding: AppStyles.mardingSymmetricHor,
        shape: AppStyles.mainShapeMini,
        visualDensity: VisualDensity.compact,
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
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Icon(
          Icons.folder,
          color: AppStyles.collectionColors[collectionModel.color],
        ),
        trailing: Consumer<FavoriteWordsState>(
          builder: (BuildContext context, _, __) {
            return FutureBuilder<int>(
              future: Provider.of<CollectionsState>(context, listen: false).getWordCount(collectionId: collectionModel.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
