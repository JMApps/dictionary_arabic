import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/forms_text.dart';
import '../widgets/translation_double.dart';

class DetailRootWordItem extends StatelessWidget {
  const DetailRootWordItem({
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
                  arguments: WordArgs(wordId: model.nr),
                );
              },
              backgroundColor: CupertinoColors.systemBlue,
              icon: CupertinoIcons.bookmark,
            ),
          ],
        ),
        child: CupertinoListTile(
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.wordDetailPage,
              arguments: WordArgs(wordId: model.nr),
            );
          },
          padding: AppStyles.mainMardingMini,
          backgroundColor: CupertinoColors.secondarySystemFill,
          title: CupertinoListTile(
            padding: AppStyles.mardingSymmetricHorMini,
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
                        fontFamily: 'Arial',
                      ),
                    )
                        : const SizedBox(),
                    const SizedBox(width: 7),
                    model.form != null
                        ? Text(
                      model.form!,
                      style: const TextStyle(
                        fontSize: 18,
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
                    fontSize: 25,
                    color: CupertinoColors.systemIndigo,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          subtitle: CupertinoListTile(
            padding: AppStyles.mardingOnlyLeftMini,
            title: TranslationDouble(translation: model.translation),
          ),
        ),
      ),
    );
  }
}
