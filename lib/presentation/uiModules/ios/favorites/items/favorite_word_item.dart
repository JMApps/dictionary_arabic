import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';
import '../move_word_select.dart';

class FavoriteWordItem extends StatelessWidget {
  const FavoriteWordItem({
    super.key,
    required this.model,
  });

  final FavoriteDictionaryEntity model;

  @override
  @override
  Widget build(BuildContext context) {
    List<String> translationLines = model.translation.split('\\n');
    return Padding(
      padding: AppStyles.mardingOnlyBottomMini,
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
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.share,
            ),
            SlidableAction(
              onPressed: (context) {
                showCupertinoModalPopup(context: context, builder: (_) => MoveWordSelect(wordNumber: model.wordNumber, oldCollectionId: model.collectionId));
              },
              backgroundColor: CupertinoColors.systemIndigo,
              icon: CupertinoIcons.folder_fill,
            ),
            SlidableAction(
              onPressed: (context) async {
                await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(favoriteWordId: model.id, collectionId: model.collectionId);
              },
              backgroundColor: CupertinoColors.systemRed,
              icon: CupertinoIcons.delete_solid,
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
              arguments: WordArgs(wordNumber: model.wordNumber)
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
                const SizedBox(width: 18),
                model.additional != null
                    ? Text(
                  '${model.additional!} ',
                  style: const TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                    fontFamily: 'SF Pro Regular',
                  ),
                )
                    : const SizedBox(),
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
                    model.homonymNr != null ? Text(
                      model.homonymNr!.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: CupertinoColors.systemGrey,
                        fontFamily: 'SF Pro Regular',
                      ),
                    ) : const SizedBox(),
                    const SizedBox(width: 7),
                    model.vocalization != null ? Text(
                            model.vocalization!,
                            style: const TextStyle(
                              fontSize: 17,
                              color: CupertinoColors.systemGrey,
                              fontFamily: 'SF Pro Regular',
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 7),
                    model.form != null ? Text(
                            model.form!,
                            style: const TextStyle(
                              fontFamily: 'Heuristica',
                              letterSpacing: 0.5,
                            ),
                          ) : const SizedBox(),
                  ],
                ),
                Text(
                  model.root,
                  style: const TextStyle(
                    fontSize: 20,
                    color: CupertinoColors.systemPink,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: ShortTranslationText(translation: model.serializableIndex == -1 ? model.translation : translationLines[model.serializableIndex]),
        ),
      ),
    );
  }
}
