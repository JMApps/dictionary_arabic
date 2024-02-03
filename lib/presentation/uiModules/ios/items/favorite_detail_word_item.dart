import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/favorite_detail_translation_double.dart';
import '../widgets/forms_text.dart';

class FavoriteDetailWordItem extends StatefulWidget {
  const FavoriteDetailWordItem({
    super.key,
    required this.model,
  });

  final FavoriteDictionaryEntity model;

  @override
  State<FavoriteDetailWordItem> createState() => _FavoriteDetailWordItemState();
}

class _FavoriteDetailWordItemState extends State<FavoriteDetailWordItem> {
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
            onPressed: (context) {},
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.eye,
          ),
        ],
      ),
      child: CupertinoListTile(
        padding: AppStyles.mainMarding,
        title: CupertinoListTile(
          padding: EdgeInsets.zero,
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
        subtitle: FavoriteDetailTranslationDouble(
          translation: widget.model.translation.replaceAll('\\n', '\n\n'),
        ),
      ),
    );
  }
}
