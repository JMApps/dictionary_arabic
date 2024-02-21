import 'package:flutter/material.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import 'forms_text.dart';
import 'short_translation_text.dart';

class RootWordItem extends StatelessWidget {
  const RootWordItem({
    super.key,
    required this.wordModel,
    required this.index,
  });

  final DictionaryEntity wordModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Padding(
      padding: AppStyles.mardingOnlyBottom,
      // child: Slidable(
      //   endActionPane: ActionPane(
      //     motion: const StretchMotion(),
      //     children: [
      //       SlidableAction(
      //         onPressed: (context) {
      //           Share.share(
      //             wordModel.wordContent(),
      //             sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
      //           );
      //         },
      //         backgroundColor: CupertinoColors.systemBlue,
      //         icon: CupertinoIcons.share,
      //       ),
      //       SlidableAction(
      //         onPressed: (context) {
      //           Navigator.pushNamed(
      //             context,
      //             RouteNames.addFavoriteWordPage,
      //             arguments: WordArgs(wordNumber: wordModel.wordNumber),
      //           );
      //         },
      //         backgroundColor: CupertinoColors.systemIndigo,
      //         icon: CupertinoIcons.bookmark,
      //       ),
      //     ],
      //   ),
      child: ListTile(
        contentPadding: AppStyles.mainMarding,
        tileColor: appColors.inversePrimary.withOpacity(0.1),
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordNumber: wordModel.wordNumber),
          );
        },
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              Text(
                wordModel.arabicWord,
                style: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(width: 14),
              wordModel.forms != null
                  ? FormsText(content: wordModel.forms!)
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
                  wordModel.vocalization != null
                      ? Text(
                          wordModel.vocalization!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontFamily: 'SF Pro Regular',
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 7),
                  wordModel.form != null
                      ? Text(
                          wordModel.form!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Heuristica',
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Text(
                wordModel.root,
                style: TextStyle(
                  fontSize: 25,
                  color: appColors.error,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        subtitle: ShortTranslationText(translation: wordModel.translation),
      ),
    );
  }
}
