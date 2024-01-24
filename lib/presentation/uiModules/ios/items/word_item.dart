import 'package:flutter/cupertino.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
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
    RegExp arabic = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');
    TextStyle defaultStyle = TextStyle(
      fontSize: 18,
      color: CupertinoColors.label.resolveFrom(context),
      fontFamily: 'Arial',
      height: 1.5,
    );

    TextStyle arabicStyle = const TextStyle(
      fontSize: 18,
      color: CupertinoColors.systemBlue,
      fontFamily: 'Uthmanic',
      height: 1.5,
    );
    List<TextSpan> getSpans(String text, RegExp regex) {
      List<TextSpan> spans = [];

      var matches = regex.allMatches(text);
      int start = 0;

      for (var match in matches) {
        if (start < match.start) {
          spans.add(
            TextSpan(
              text: text.substring(start, match.start).replaceAll('\\n', '\n'),
              style: defaultStyle,
            ),
          );
        }

        spans.add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: arabicStyle,
          ),
        );

        start = match.end;
      }

      if (start < text.length) {
        spans.add(
          TextSpan(
            text: text.substring(start).replaceAll('\\n', '\n'),
            style: defaultStyle,
          ),
        );
      }

      return spans;
    }
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
              model.forms != null
                  ? Text.rich(
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
                              fontSize: 22,
                              color: CupertinoColors.systemGrey,
                              fontFamily: 'Uthmanic',
                            ),
                          ),
                        ],
                      ),
                      textDirection: TextDirection.ltr,
                    )
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
          title: RichText(
            text: TextSpan(
              children: getSpans(model.translation, arabic),
            ),
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
