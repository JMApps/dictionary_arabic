import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/forms_text.dart';
import '../widgets/translation_double.dart';

class FavoriteWordItem extends StatelessWidget {
  const FavoriteWordItem({
    super.key,
    required this.model,
    required this.index,
  });

  final FavoriteDictionaryEntity model;
  final int index;

  @override
  @override
  Widget build(BuildContext context) {
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
              backgroundColor: CupertinoColors.systemIndigo,
              icon: CupertinoIcons.share,
            ),
            SlidableAction(
              onPressed: (context) {
                // Переместить в другую коллекцию
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.arrow_turn_up_right,
            ),
            SlidableAction(
              onPressed: (context) async {
                await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(favoriteWordId: model.id);
              },
              backgroundColor: CupertinoColors.systemRed,
              icon: CupertinoIcons.delete_solid,
            ),
          ],
        ),
        child: CupertinoListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.wordFavoriteDetailPage,
              arguments: WordArgs(wordId: model.id)
            );
          },
          padding: AppStyles.mainMardingMini,
          backgroundColor: CupertinoColors.quaternarySystemFill,
          title: CupertinoListTile(
            padding: AppStyles.mardingSymmetricHor,
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
                              fontSize: 17,
                              color: CupertinoColors.systemGrey,
                              fontFamily: 'Arial',
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 7),
                    model.form != null
                        ? Text(
                            model.form!,
                            style: const TextStyle(
                              fontFamily: 'SF Pro',
                              letterSpacing: 0.5,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  model.root,
                  style: const TextStyle(
                    fontSize: 20,
                    color: CupertinoColors.systemIndigo,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: CupertinoListTile(
            padding: AppStyles.mardingSymmetricHorMini,
            title: TranslationDouble(translation: model.translation),
          ),
        ),
      ),
    );
  }
}
