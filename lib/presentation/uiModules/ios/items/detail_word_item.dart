import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/args/word_args.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../widgets/detail_translation_double.dart';
import '../widgets/forms_text.dart';

class DetailWordItem extends StatefulWidget {
  const DetailWordItem({
    super.key,
    required this.model,
  });

  final DictionaryEntity model;

  @override
  State<DetailWordItem> createState() => _DetailWordItemState();
}

class _DetailWordItemState extends State<DetailWordItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Share.share(
                widget.model.wordContent(),
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
                arguments: WordArgs(wordId: widget.model.nr),
              );
            },
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.bookmark,
          ),
        ],
      ),
      child: CupertinoListTile(
        padding: AppStyles.mardingWithoutBottomMini,
        title: CupertinoListTile(
          padding: AppStyles.mardingWithoutBottomMini,
          title: Row(
            children: [
              Text(
                widget.model.arabicWord,
                style: const TextStyle(
                  fontSize: 50,
                  fontFamily: 'Uthmanic',
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(width: 14),
              widget.model.forms != null
                  ? FormsText(content: widget.model.forms!)
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
                  widget.model.vocalization != null
                      ? Text(
                          widget.model.vocalization!,
                          style: const TextStyle(
                            fontSize: 20,
                            color: CupertinoColors.systemGrey,
                            fontFamily: 'Arial',
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(width: 7),
                  widget.model.form != null
                      ? Text(
                          widget.model.form!,
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily: 'SF Pro',
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Text(
                widget.model.root,
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
        subtitle: CupertinoListTile(
          padding: AppStyles.verticalHorizontalMini,
          title: DetailTranslationDouble(
            translation: widget.model.translation.replaceAll('\\n', '\n\n'),
          ),
        ),
      ),
    );
  }
}