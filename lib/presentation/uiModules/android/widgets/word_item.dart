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
      padding: AppStyles.mardingOnlyBottom,
      child: /*Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Share.share(
                  model.wordContent(),
                  sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                );
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.share,
            ),
            Consumer<FavoriteWordsState>(
              builder: (BuildContext context, FavoriteWordsState favoriteWordState, _) {
                return FutureBuilder<bool>(
                    future: favoriteWordState.fetchIsWordFavorite(wordId: model.wordNumber),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      } else if (snapshot.hasData) {
                        final bool isFavorite = snapshot.data!;
                        return SlidableAction(
                          onPressed: (context) {
                            if (isFavorite) {
                              Navigator.pushNamed(
                                  context,
                                  RouteNames.wordFavoriteDetailPage,
                                  arguments: WordArgs(wordNumber: model.wordNumber)
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                RouteNames.addFavoriteWordPage,
                                arguments: WordArgs(wordNumber: model.wordNumber),
                              );
                            }
                          },
                          backgroundColor: CupertinoColors.systemIndigo,
                          icon: isFavorite
                              ? CupertinoIcons.bookmark_fill
                              : CupertinoIcons.bookmark,
                        );
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    }
                );
              },
            ),
          ],
        ),*/
          ListTile(
        contentPadding: AppStyles.mainMarding,
        tileColor: appColors.inversePrimary.withOpacity(0.1),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordNumber: model.wordNumber),
          );
        },
        title: ListTile(
          contentPadding: EdgeInsets.zero,
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
                  fontSize: 25,
                  color: appColors.error,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
        subtitle: ShortTranslationText(translation: model.translation),
      ),
    );
  }
}
