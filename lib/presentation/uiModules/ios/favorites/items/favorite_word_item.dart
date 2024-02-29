import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    List<String> splitTranslationText = favoriteWordModel.translation.split('\\n');
    return Padding(
      padding: AppStyles.mardingOnlyBottom,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => ChangeSerializableFavoriteWord(
                    favoriteWordModel: favoriteWordModel,
                  ),
                );
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.eye,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  RouteNames.moveFavoriteWordPage,
                  arguments: WordMoveArgs(
                    wordNumber: favoriteWordModel.wordNumber,
                    oldCollectionId: favoriteWordModel.collectionId,
                  ),
                );
              },
              backgroundColor: CupertinoColors.systemIndigo,
              icon: CupertinoIcons.folder_fill,
            ),
            SlidableAction(
              onPressed: (context) async {
                await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(
                  favoriteWordId: favoriteWordModel.wordNumber,
                );
              },
              backgroundColor: CupertinoColors.systemRed,
              icon: CupertinoIcons.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Share.share(
                  favoriteWordModel.wordContent(),
                  sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                );
              },
              backgroundColor: CupertinoColors.systemGrey,
              icon: CupertinoIcons.share,
            ),
          ],
        ),
        child: CupertinoListTile(
          padding: AppStyles.mainMarding,
          backgroundColor: CupertinoColors.quaternarySystemFill,
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.wordFavoriteDetailPage,
              arguments: WordArgs(wordNumber: favoriteWordModel.wordNumber),
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
                      subtitle: ShortTranslationText(
                        translation: favoriteWordModel.serializableIndex == -1
                            ? favoriteWordModel.translation
                            : splitTranslationText[favoriteWordModel.serializableIndex],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          favoriteWordModel.homonymNr != null
                              ? Text(
                                  favoriteWordModel.homonymNr.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 4),
                          favoriteWordModel.vocalization != null
                              ? Text(
                                  favoriteWordModel.vocalization!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: CupertinoColors.systemGrey,
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
                      const SizedBox(height: 7),
                      Text(
                        favoriteWordModel.root,
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
