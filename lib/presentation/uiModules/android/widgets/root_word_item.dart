import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/favorite_words_state.dart';
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
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.15);
    return Container(
      margin: AppStyles.mardingOnlyBottomMini,
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            RouteNames.wordDetailPage,
            arguments: WordArgs(wordNumber: wordModel.wordNumber),
          );
        },
        child: Container(
          padding: AppStyles.mainMarding,
          color: index.isOdd ? itemOddColor : itemEvenColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
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
                    const SizedBox(height: 8),
                    ShortTranslationText(
                      translation: wordModel.translation,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      wordModel.homonymNr != null
                          ? Text(
                              wordModel.homonymNr.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: appColors.onSurface,
                                fontFamily: 'SF Pro Regular',
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 4),
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
                      const SizedBox(width: 4),
                      wordModel.form != null
                          ? Text(
                              wordModel.form!,
                              style: const TextStyle(
                                fontSize: 15,
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
                      fontSize: 25,
                      color: appColors.error,
                      fontFamily: 'Uthmanic',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Consumer<FavoriteWordsState>(
                    builder: (BuildContext context, favoriteWordState, _) {
                      return FutureBuilder<bool>(
                          future: favoriteWordState.fetchIsWordFavorite(wordNumber: wordModel.wordNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final bool isFavorite = snapshot.data!;
                              return IconButton(
                                onPressed: () {
                                  if (isFavorite) {
                                    Navigator.pushNamed(
                                        context,
                                        RouteNames.wordFavoriteDetailPage,
                                        arguments: WordArgs(wordNumber: wordModel.wordNumber)
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.addFavoriteWordPage,
                                      arguments: WordArgs(wordNumber: wordModel.wordNumber),
                                    );
                                  }
                                },
                                icon: Icon(isFavorite
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline_rounded,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Share.share(
                        wordModel.wordContent(),
                        sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                      );
                    },
                    icon: const Icon(Icons.share),
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
