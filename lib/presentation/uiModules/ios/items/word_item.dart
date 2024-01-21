import 'package:arabic/core/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/dictionary_entity.dart';

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
    return Container(
      margin: AppStyles.mardingOnlyBottomMini,
      child: CupertinoListTile(
        onTap: () {},
        backgroundColor: CupertinoColors.systemFill,
        padding: AppStyles.mainMarding,
        title: Row(
          children: [
            Text(
              model.arabicWord,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Uthmanic',
              ),
            ),
            const SizedBox(width: 7),
            model.plural != null
                ? Text(
                    model.plural!,
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey2,
                      fontSize: 20,
                      fontFamily: 'Uthmanic',
                    ),
                  )
                : const SizedBox()
          ],
        ),
        subtitle: Text(
          model.meaning ?? 'Перевод недоступен',
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Arial',
            height: 1.5,
          ),
          maxLines: 4,
        ),
        trailing: Column(
          children: [
            Text(
              model.other ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Arial',
              ),
            ),
            Text(
              model.arabicRoot,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Uthmanic',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
