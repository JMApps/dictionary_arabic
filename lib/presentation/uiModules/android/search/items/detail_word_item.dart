import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/translation_text.dart';

class DetailWordItem extends StatelessWidget {
  const DetailWordItem({
    super.key,
    required this.wordModel,
  });

  final DictionaryEntity wordModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Container(
      margin: AppStyles.mardingWithoutTopMini,
      child: InkWell(
        borderRadius: AppStyles.mainBorderMini,
        child: Container(
          padding: AppStyles.wordCardMarding,
          decoration: BoxDecoration(
            color: appColors.primary.withOpacity(0.05),
            borderRadius: AppStyles.mainBorderMini,
          ),
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
                            fontSize: 50,
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
                    TranslationText(
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
                      wordModel.homonymNr != null
                          ? Text(
                              wordModel.homonymNr.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: appColors.onSurface,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 4),
                      wordModel.vocalization != null
                          ? Text(
                              wordModel.vocalization!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 4),
                      wordModel.form != null
                          ? Text(
                              wordModel.form!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Heuristica',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wordModel.root,
                    style: TextStyle(
                      fontSize: 30,
                      color: appColors.error,
                      fontFamily: 'Uthmanic',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Consumer<FavoriteWordsState>(
                    builder: (BuildContext context, favoriteWordState, _) {
                      return FutureBuilder<bool>(
                          future: favoriteWordState.fetchIsWordFavorite(wordNumber: wordModel.wordNumber),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final bool isFavorite = snapshot.data!;
                              return Column(
                                children: [
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
                                        await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(
                                          favoriteWordId: wordModel.wordNumber,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline_rounded,
                                      size: 30,
                                      color: appColors.primary,
                                    ),
                                  ),
                                  isFavorite
                                      ? IconButton(
                                          visualDensity: VisualDensity.compact,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.drive_file_move_rounded,
                                            color: appColors.tertiary,
                                          ),
                                        ) : const SizedBox(),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                      );
                    },
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