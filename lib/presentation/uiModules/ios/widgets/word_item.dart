import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import 'forms_text.dart';
import 'short_translation_text.dart';

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
      padding: AppStyles.mardingOnlyBottom,
      child: Slidable(
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
              backgroundColor: CupertinoColors.systemIndigo,
              icon: CupertinoIcons.share,
            ),
            FutureBuilder<bool>(
              future: Provider.of<FavoriteWordsState>(context, listen: false).fetchIsWordFavorite(wordId: model.wordNumber),
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
                            arguments: WordArgs(wordNr: model.wordNumber)
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          RouteNames.addFavoriteWordPage,
                          arguments: WordArgs(wordNr: model.wordNumber),
                        );
                      }
                    },
                    backgroundColor: CupertinoColors.systemBlue,
                    icon: isFavorite
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              }
            ),
          ],
        ),
        child: CupertinoListTile(
          padding: AppStyles.mainMarding,
          backgroundColor: CupertinoColors.secondarySystemFill,
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.wordDetailPage,
              arguments: WordArgs(wordNr: model.wordNumber),
            );
          },
          title: CupertinoListTile(
            padding: EdgeInsets.zero,
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
                        color: CupertinoColors.systemGrey,
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
                  style: const TextStyle(
                    fontSize: 25,
                    color: CupertinoColors.systemPink,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: ShortTranslationText(translation: model.translation),
        ),
      ),
    );
  }
}
