import 'package:arabic/domain/entities/dictionary_entity.dart';
import 'package:flutter/cupertino.dart';

class WordItem extends StatelessWidget {
  const WordItem({
    super.key,
    required this.model,
    required this.index,
  });

  final DictionaryEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(model.arabicWord),
      subtitle: Text(model.shortMeaning ?? 'Перевод недоступен'),
    );
  }
}
