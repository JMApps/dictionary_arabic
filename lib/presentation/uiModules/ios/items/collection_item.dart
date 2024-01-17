import 'package:arabic/core/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/collection_entity.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.model,
    required this.index,
  });

  final CollectionEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () {
        // Navigate to collection page
      },
      title: Text(model.title),
      leading: Icon(CupertinoIcons.circle_fill, color: AppStyles.collectionColors[model.color]),
      additionalInfo: Text(model.wordsCount.toString()),
    );
  }
}
