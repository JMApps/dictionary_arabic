import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';
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
              Text(
                model.plural ?? '',
                style: const TextStyle(
                  fontSize: 25,
                  color: CupertinoColors.systemGrey2,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              model.other != null
                  ? Text(
                      model.other!,
                      style: const TextStyle(
                        fontFamily: 'Uthmanic',
                      ),
                    )
                  : const SizedBox(),
              Text(
                model.arabicRoot,
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
            formatMeaning(
              model.meaning ?? AppStrings.translationNotAvailable,
            ),
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Arial',
              height: 1.5,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(CupertinoIcons.bookmark),
        ),
      ),
    );
  }

  String formatMeaning(String meaning) {
    return meaning.replaceAllMapped(
        RegExp(r'(\d{1,2})\)\s*([^;]+); '),
            (match) => '${match[1]}) ${match[2]};\n'
    );
  }
}
