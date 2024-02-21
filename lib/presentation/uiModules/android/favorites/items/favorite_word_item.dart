import 'package:flutter/material.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/args/word_args.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/short_translation_text.dart';

class FavoriteWordItem extends StatelessWidget {
  const FavoriteWordItem({
    super.key,
    required this.model,
  });

  final FavoriteDictionaryEntity model;

  @override
  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    List<String> translationLines = model.translation.split('\\n');
    return Padding(
      padding: AppStyles.mardingOnlyBottomMini,
      // child: Slidable(
      //   endActionPane: ActionPane(
      //     motion: const StretchMotion(),
      //     children: [
      //       SlidableAction(
      //         onPressed: (context) {
      //           Share.share(
      //             model.wordContent(),
      //             sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
      //           );
      //         },
      //         backgroundColor: CupertinoColors.systemBlue,
      //         icon: CupertinoIcons.share,
      //       ),
      //       SlidableAction(
      //         onPressed: (context) {
      //           showCupertinoModalPopup(context: context, builder: (_) => MoveWordSelect(wordNumber: model.wordNumber, oldCollectionId: model.collectionId));
      //         },
      //         backgroundColor: CupertinoColors.systemIndigo,
      //         icon: CupertinoIcons.folder_fill,
      //       ),
      //       SlidableAction(
      //         onPressed: (context) async {
      //           await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(favoriteWordId: model.id, collectionId: model.collectionId);
      //         },
      //         backgroundColor: CupertinoColors.systemRed,
      //         icon: CupertinoIcons.delete_solid,
      //       ),
      //     ],
      //   ),
        child: ListTile(
          contentPadding: AppStyles.mainMarding,
          tileColor: appColors.inversePrimary.withOpacity(0.1),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.wordFavoriteDetailPage,
              arguments: WordArgs(wordNumber: model.wordNumber)
            );
          },
          title: ListTile(
            contentPadding: EdgeInsets.zero,
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
                    color: Colors.grey,
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
                        color: Colors.grey,
                        fontFamily: 'SF Pro Regular',
                      ),
                    ) : const SizedBox(),
                    const SizedBox(width: 7),
                    model.vocalization != null ? Text(
                            model.vocalization!,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
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
                  style: TextStyle(
                    fontSize: 20,
                    color: appColors.error,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: ShortTranslationText(translation: model.serializableIndex == -1 ? model.translation : translationLines[model.serializableIndex]),
        ),
    );
  }
}
