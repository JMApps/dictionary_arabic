import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import 'forms_text.dart';
import 'short_translation_text.dart';

class RootWordItem extends StatelessWidget {
  const RootWordItem({
    super.key,
    required this.model,
    required this.index,
  });

  final DictionaryEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.mardingOnlyBottom,
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
                Navigator.pushNamed(
                  context,
                  RouteNames.addFavoriteWordPage,
                  arguments: WordArgs(wordNr: model.nr),
                );
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.bookmark,
            ),
          ],
        ),
        child: CupertinoListTile(
          padding: AppStyles.mainMarding,
          backgroundColor: CupertinoColors.secondarySystemFill,
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.wordDetailPage,
              arguments: WordArgs(wordNr: model.nr),
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
                const SizedBox(width: 14),
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
                        fontSize: 18,
                        color: CupertinoColors.systemGrey,
                        fontFamily: 'SF Pro Regular',
                      ),
                    )
                        : const SizedBox(),
                    const SizedBox(width: 7),
                    model.form != null
                        ? Text(
                      model.form!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Heuristica',
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  model.root,
                  style: const TextStyle(
                    fontSize: 25,
                    color: CupertinoColors.systemPink,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: ShortTranslationText(translation: model.translation),
        ),
      ),
    );
  }
}
