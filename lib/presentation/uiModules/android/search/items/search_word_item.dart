import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';

class SearchWordItem extends StatelessWidget {
  const SearchWordItem({super.key,
    required this.wordModel,
    required this.index,
  });

  final DictionaryEntity wordModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
    return Container(
      margin: AppStyles.mardingWithoutTopMini,
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
          padding: AppStyles.wordCardMarding,
          decoration: BoxDecoration(
            color: index.isOdd ? itemOddColor : itemEvenColor,
            borderRadius: AppStyles.mainBorderMini,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ) : const SizedBox(),
                          const SizedBox(width: 4),
                          wordModel.form != null ? Text(
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
                      const SizedBox(height: 4),
                      Text(
                        wordModel.root,
                        style: TextStyle(
                          fontSize: 22,
                          color: appColors.error,
                          fontFamily: 'Uthmanic',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<FavoriteWordsState>(
                    builder: (BuildContext context, favoriteWordState, _) {
                      return FutureBuilder<bool>(
                          future: favoriteWordState.fetchIsWordFavorite(wordNumber: wordModel.wordNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final bool isFavorite = snapshot.data!;
                              return Row(
                                children: [
                                  isFavorite ? IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.drive_file_move_rounded,
                                      color: appColors.tertiary,
                                    ),
                                  ) : const SizedBox(),
                                  IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () async {
                                      if (!isFavorite) {
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.addFavoriteWordPage,
                                          arguments: WordArgs(
                                            wordNumber: wordModel.wordNumber,
                                          ),
                                        );
                                      } else {
                                        await favoriteWordState.deleteFavoriteWord(
                                          favoriteWordId: wordModel.wordNumber,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      isFavorite? Icons.bookmark : Icons.bookmark_outline_rounded,
                                      color: appColors.primary,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
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
                      Icons.ios_share_rounded,
                      color: appColors.tertiary,
                    ),
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