import 'package:flutter/cupertino.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/add_favorite_word_button.dart';
import '../widgets/forms_text.dart';
import '../widgets/search_translation_double.dart';
import '../widgets/share_word_button.dart';

class SearchWordItem extends StatelessWidget {
  const SearchWordItem({
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
          padding: AppStyles.mardingSymmetricHorMini,
          title: Row(
            children: [
              Text(
                model.arabicWord,
                style: const TextStyle(
                  fontSize: 45,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(width: 14),
              model.forms != null ? FormsText(content: model.forms!) : const SizedBox(),
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
                            fontSize: 20,
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
                  fontSize: 22,
                  color: CupertinoColors.systemBlue,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        subtitle: CupertinoListTile(
          padding: AppStyles.mardingOnlyLeftMini,
          title: SearchTranslationDouble(translation: model.translation),
          trailing: Column(
            children: [
              AddFavoriteWordButton(nr: model.nr),
              ShareWordButton(content: model.wordContent().replaceAll('\\n', '\n\n')),
            ],
          ),
        ),
      ),
    );
  }
}
