import 'package:arabic/domain/entities/dictionary_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(model.arabicWord),
          Text(model.arabicRoot),
          Text(model.plural ?? ''),
          Text(model.shortMeaning ?? 'Перевод недоступен'),
          Text(model.other ?? ''),
        ],
      ),
    );
  }
}
