import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/args/word_move_args.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';
import '../lists/change_serializable_favorite_word.dart';

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
    List<String> splitTranslationText = favoriteWordModel.translation.split('\\n');
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
          padding: AppStyles.mardingWithoutBottom,
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
                            favoriteWordModel.arabicWord,
                            style: const TextStyle(
                              fontSize: 35,
                              fontFamily: 'Uthmanic',
                              height: 1,
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
                      subtitle: Padding(
                        padding: AppStyles.mardingOnlyTop,
                        child: ShortTranslationText(
                          translation: favoriteWordModel.serializableIndex == -1
                              ? favoriteWordModel.translation
                              : splitTranslationText[favoriteWordModel.serializableIndex],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                ) : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        favoriteWordModel.root,
                        style: TextStyle(
                          fontSize: 22,
                          color: appColors.error,
                          fontFamily: 'Uthmanic',
                          height: 1,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ChangeSerializableFavoriteWord(
                          favoriteWordModel: favoriteWordModel,
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: appColors.tertiary.withOpacity(0.75),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.moveFavoriteWordPage,
                        arguments: WordMoveArgs(
                          wordNumber: favoriteWordModel.wordNumber,
                          oldCollectionId: favoriteWordModel.collectionId,
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.drive_file_move_rounded,
                      color: appColors.tertiary.withOpacity(0.75),
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
                      color: appColors.tertiary.withOpacity(0.75),
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
                      color: appColors.tertiary.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
