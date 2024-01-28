import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/favorite_dictionary_entity.dart';

class FavoriteWordItem extends StatelessWidget {
  const FavoriteWordItem({
    super.key,
    required this.model,
    required this.index,
  });

  final FavoriteDictionaryEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(model.arabicWord),
      subtitle: Text(model.translation),
    );
  }
}
