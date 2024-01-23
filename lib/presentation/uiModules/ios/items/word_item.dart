import 'package:flutter/cupertino.dart';

import '../../../../core/styles/app_styles.dart';
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
    return Padding(
      padding: AppStyles.mardingOnlyBottomMini,
      child: CupertinoListTile(
        padding: AppStyles.mainMardingMini,
        backgroundColor: CupertinoColors.systemFill,
        title: CupertinoListTile(
          padding: AppStyles.mardingSymmetricHor,
          title: Row(
            children: [
              Text(
                model.arabicWord,
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(width: 14),
              model.forms != null ? Text.rich(
                TextSpan(
                  children: [
                    if (model.forms!.contains('мн.'))
                      const TextSpan(
                        text: 'мн.',
                        style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.systemGrey2,
                          fontFamily: 'Arial',
                        ),
                      ),
                    TextSpan(
                      text: model.forms!.replaceAll('мн.', ''),
                      style: const TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.systemGrey2,
                        fontFamily: 'Uthmanic',
                      ),
                    ),
                  ],
                ),
                textDirection: TextDirection.ltr,
              ) : const SizedBox(),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              model.form != null
                  ? Text(
                      model.form!,
                      style: const TextStyle(
                        fontFamily: 'Uthmanic',
                      ),
                    )
                  : const SizedBox(),
              Text(
                model.root,
                style: const TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        subtitle: CupertinoListTile(
          padding: AppStyles.mardingSymmetricHorMini,
          title: Text(
            model.translation.replaceAll('\\n', '\n'),
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Arial',
              height: 1.5,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: CupertinoButton(
            onPressed: () {
              // Открыть окно для добавления слова в избранное
            },
            child: const Icon(CupertinoIcons.bookmark),
          ),
        ),
      ),
    );
  }
}
