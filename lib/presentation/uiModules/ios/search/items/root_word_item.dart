import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';

class RootWordItem extends StatelessWidget {
  const RootWordItem({
    super.key,
    required this.wordModel,
  });

  final DictionaryEntity wordModel;

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
                  wordModel.wordContent(),
                  sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                );
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.share,
            ),
            Consumer<FavoriteWordsState>(
              builder: (BuildContext context, favoriteWordState, _) {
                return FutureBuilder<bool>(
                  future: favoriteWordState.fetchIsWordFavorite(wordNumber: wordModel.wordNumber),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final bool isFavorite = snapshot.data!;
                      return SlidableAction(
                        onPressed: (context) {
                          if (isFavorite) {
                            Navigator.pushNamed(
                              context,
                              RouteNames.wordFavoriteDetailPage,
                              arguments:
                              WordArgs(wordNumber: wordModel.wordNumber),
                            );
                          } else {
                            Navigator.pushNamed(
                              context,
                              RouteNames.addFavoriteWordPage,
                              arguments:
                              WordArgs(wordNumber: wordModel.wordNumber),
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
                  },
                );
              },
            ),
          ],
        ),
        child: CupertinoListTile(
          padding: AppStyles.mainMarding,
          backgroundColor: CupertinoColors.quaternarySystemFill,
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.wordDetailPage,
              arguments: WordArgs(wordNumber: wordModel.wordNumber),
            );
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CupertinoListTile(
                      padding: EdgeInsets.zero,
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
                          const SizedBox(width: 8),
                          wordModel.forms != null
                              ? FormsText(content: wordModel.forms!)
                              : const SizedBox(),
                          const SizedBox(width: 8),
                          wordModel.additional != null
                              ? FormsText(content: wordModel.additional!)
                              : const SizedBox(),
                        ],
                      ),
                      subtitle: ShortTranslationText(
                          translation: wordModel.translation),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          wordModel.homonymNr != null
                              ? Text(
                            wordModel.homonymNr.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: CupertinoColors.systemGrey,
                            ),
                          )
                              : const SizedBox(),
                          const SizedBox(width: 4),
                          wordModel.vocalization != null
                              ? Text(
                            wordModel.vocalization!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: CupertinoColors.systemGrey,
                            ),
                          )
                              : const SizedBox(),
                          const SizedBox(width: 4),
                          wordModel.form != null
                              ? Text(
                            wordModel.form!,
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
                      const SizedBox(height: 7),
                      Text(
                        wordModel.root,
                        style: const TextStyle(
                          fontSize: 22,
                          color: CupertinoColors.systemRed,
                          fontFamily: 'Uthmanic',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
