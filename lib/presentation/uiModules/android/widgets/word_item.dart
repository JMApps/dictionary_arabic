import 'package:flutter/material.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import 'forms_text.dart';
import 'short_translation_text.dart';

class WordItem extends StatelessWidget {
  const WordItem({
    super.key,
    required this.model,
  });

  final DictionaryEntity model;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Padding(
      padding: AppStyles.mardingOnlyBottomMini,
      child: ListTile(
        contentPadding: AppStyles.mainMarding,
        tileColor: appColors.inversePrimary.withOpacity(0.15),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordNumber: model.wordNumber),
          );
        },
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
            const SizedBox(width: 16),
            model.forms != null
                ? FormsText(content: model.forms!)
                : const SizedBox(),
          ],
        ),
        subtitle: ShortTranslationText(
          translation: model.translation,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                model.vocalization != null
                    ? Text(
                  model.vocalization!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontFamily: 'SF Pro Regular',
                  ),
                )
                    : const SizedBox(),
                const SizedBox(width: 7),
                model.form != null
                    ? Text(
                  model.form!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Heuristica',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                )
                    : const SizedBox(),
              ],
            ),
            Text(
              model.root,
              style: TextStyle(
                fontSize: 20,
                color: appColors.error,
                fontFamily: 'Uthmanic',
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
