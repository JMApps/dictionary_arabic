import 'package:arabic/domain/entities/collection_entity.dart';
import 'package:flutter/cupertino.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.model,
    required this.index,
    required this.wordCount,
  });

  final CollectionEntity model;
  final int index;
  final int wordCount;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () {
        // Navigate to collection page
      },
      title: Text(model.title),
      additionalInfo: Text(wordCount.toString()),
    );
  }
}
