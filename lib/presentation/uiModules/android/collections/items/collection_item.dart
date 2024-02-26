import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/collections_state.dart';
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
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.15);
    return Container(
      margin: AppStyles.mardingOnlyBottom,
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
        trailing: FutureBuilder<int>(
          future: Provider.of<CollectionsState>(context).getWordCount(collectionId: collectionModel.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data.toString(),
                style: const TextStyle(fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
