import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import 'forms_text.dart';
import 'short_translation_text.dart';

class MainWordItem extends StatelessWidget {
  const MainWordItem({
    super.key,
    required this.wordModel,
    required this.index,
  });

  final DictionaryEntity wordModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.15);
    return Container(
      margin: AppStyles.mardingWithoutTop,
      child: InkWell(
        borderRadius: AppStyles.mainBorderMini,
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordNumber: wordModel.wordNumber),
          );
        },
        child: Container(
          padding: AppStyles.mainMarding,
          decoration: BoxDecoration(
            color: index.isOdd ? itemOddColor : itemEvenColor,
            borderRadius: AppStyles.mainBorderMini,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListTile(
                      minVerticalPadding: 4,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                      title: Row(
                        children: [
                          Text(
                            wordModel.arabicWord,
                            style: const TextStyle(
                              fontSize: 35,
                              fontFamily: 'Uthmanic',
                              height: 1,
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
                      subtitle: Padding(
                        padding: AppStyles.mardingOnlyTop,
                        child: ShortTranslationText(translation: wordModel.translation),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          wordModel.homonymNr != null ? Text(
                            wordModel.homonymNr.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: appColors.onSurface,
                            ),
                          ) : const SizedBox(),
                          const SizedBox(width: 4),
                          wordModel.vocalization != null ? Text(
                            wordModel.vocalization!,
                            style: TextStyle(
                              fontSize: 18,
                              color: appColors.tertiary.withOpacity(0.75),
                            ),
                          ) : const SizedBox(),
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
                          ) : const SizedBox(),
                        ],
                      ),
                      Text(
                        wordModel.root,
                        style: TextStyle(
                          fontSize: 22,
                          color: appColors.error,
                          fontFamily: 'Uthmanic',
                          height: 1,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 8),
                      Consumer<FavoriteWordsState>(
                        builder: (BuildContext context, favoriteWordState, _) {
                          return FutureBuilder<bool>(
                            future: favoriteWordState.fetchIsWordFavorite(wordNumber: wordModel.wordNumber),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final bool wordIsFavorite = snapshot.data!;
                                return IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () async {
                                    if (!wordIsFavorite) {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.addFavoriteWordPage,
                                        arguments: WordArgs(
                                          wordNumber: wordModel.wordNumber,
                                        ),
                                      );
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.wordFavoriteDetailPage,
                                        arguments: WordArgs(wordNumber: wordModel.wordNumber),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    wordIsFavorite
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline_rounded,
                                    color: appColors.tertiary.withOpacity(0.75),
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          );
                        },
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Share.share(
                            wordModel.wordContent(),
                            sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                          );
                        },
                        icon: Icon(
                          Icons.ios_share_outlined,
                          color: appColors.tertiary.withOpacity(0.75),
                        ),
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
