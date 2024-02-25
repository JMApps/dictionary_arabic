import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';

class FavoriteWordItem extends StatelessWidget {
  const FavoriteWordItem({
    super.key,
    required this.favoriteWordModel,
    required this.index,
  });

  final FavoriteDictionaryEntity favoriteWordModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final Color itemOddColor = appColors.primary.withOpacity(0.05);
    final Color itemEvenColor = appColors.primary.withOpacity(0.10);
    List<String> translationLines = favoriteWordModel.translation.split('\\n');
    return Container(
      margin: AppStyles.mardingWithoutBottom,
      child: InkWell(
        borderRadius: AppStyles.mainBorderMini,
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.wordFavoriteDetailPage,
            arguments: WordArgs(wordNumber: favoriteWordModel.wordNumber),
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
                              favoriteWordModel.arabicWord,
                              style: const TextStyle(
                                fontSize: 35,
                                fontFamily: 'Uthmanic',
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(width: 8),
                            favoriteWordModel.forms != null
                                ? FormsText(content: favoriteWordModel.forms!)
                                : const SizedBox(),
                            const SizedBox(width: 8),
                            favoriteWordModel.additional != null
                                ? FormsText(content: favoriteWordModel.additional!)
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ShortTranslationText(translation: favoriteWordModel.serializableIndex == -1 ? favoriteWordModel.translation : translationLines[favoriteWordModel.serializableIndex]),
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
                          favoriteWordModel.homonymNr != null
                              ? Text(
                                  favoriteWordModel.homonymNr.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: appColors.onSurface,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 4),
                          favoriteWordModel.vocalization != null
                              ? Text(
                                  favoriteWordModel.vocalization!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 4),
                          favoriteWordModel.form != null
                              ? Text(
                                  favoriteWordModel.form!,
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
                      const SizedBox(height: 4),
                      Text(
                        favoriteWordModel.root,
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {},
                    icon: Icon(
                      Icons.drive_file_move_rounded,
                      color: appColors.tertiary,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(
                        favoriteWordId: favoriteWordModel.wordNumber,
                      );
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: appColors.primary,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Share.share(
                        favoriteWordModel.wordContent(),
                        sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                      );
                    },
                    icon: Icon(
                      Icons.ios_share_outlined,
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
