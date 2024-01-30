import 'package:flutter/cupertino.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/add_favorite_word_button.dart';
import '../widgets/detail_translation_double.dart';
import '../widgets/forms_text.dart';
import '../widgets/share_word_button.dart';

class WordDetailItem extends StatefulWidget {
  const WordDetailItem({
    super.key,
    required this.model,
  });

  final DictionaryEntity model;

  @override
  State<WordDetailItem> createState() => _WordDetailItemState();
}

class _WordDetailItemState extends State<WordDetailItem> {
  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      padding: AppStyles.mardingWithoutBottomMini,
      title: CupertinoListTile(
        padding: AppStyles.mardingWithoutBottomMini,
        title: Row(
          children: [
            Text(
              widget.model.arabicWord,
              style: const TextStyle(
                fontSize: 50,
                fontFamily: 'Uthmanic',
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(width: 14),
            widget.model.forms != null
                ? FormsText(content: widget.model.forms!)
                : const SizedBox(),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.model.vocalization != null
                    ? Text(
                        widget.model.vocalization!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.systemGrey,
                          fontFamily: 'Arial',
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 7),
                widget.model.form != null
                    ? Text(
                        widget.model.form!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'SF Pro',
                          letterSpacing: 0.5,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Text(
              widget.model.root,
              style: const TextStyle(
                fontSize: 25,
                color: CupertinoColors.systemIndigo,
                fontFamily: 'Uthmanic',
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
      subtitle: CupertinoListTile(
        padding: AppStyles.mardingSymmetricHorMini,
        title: DetailTranslationDouble(
          translation: widget.model.translation.replaceAll('\\n', '\n\n'),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: AddFavoriteWordButton(nr: widget.model.nr),
            ),
            Transform.scale(
              scale: 1.2,
              child: ShareWordButton(
                content: widget.model.wordContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
