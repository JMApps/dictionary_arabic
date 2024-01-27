import 'package:flutter/cupertino.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/forms_text.dart';
import '../widgets/share_word_button.dart';
import '../widgets/translation_double.dart';

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
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordId: model.nr),
          );
        },
        padding: AppStyles.mainMardingMini,
        backgroundColor: CupertinoColors.quaternarySystemFill,
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
              model.forms != null
                  ? FormsText(content: model.forms!)
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
                  model.vocalization != null
                      ? Text(
                          model.vocalization!,
                          style: const TextStyle(
                            fontSize: 17,
                            color: CupertinoColors.systemGrey,
                            fontFamily: 'Arial',
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 7),
                  model.form != null
                      ? Text(
                          model.form!,
                          style: const TextStyle(
                            fontFamily: 'SF Pro',
                            letterSpacing: 0.5,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Text(
                model.root,
                style: const TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.systemRed,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        subtitle: CupertinoListTile(
          padding: AppStyles.mardingSymmetricHorMini,
          title: TranslationDouble(translation: model.translation),
          trailing: Column(
            children: [
              CupertinoButton(
                onPressed: () {},
                child: const Icon(CupertinoIcons.bookmark),
              ),
              ShareWordButton(
                  content: model.wordContent().replaceAll('\\n', '\n\n')),
            ],
          ),
        ),
      ),
    );
  }
}
