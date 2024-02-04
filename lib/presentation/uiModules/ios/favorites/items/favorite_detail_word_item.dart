import 'package:arabic/presentation/uiModules/ios/favorites/lists/%D1%81hange_serializable_words_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../lists/serializable_detail_words_list.dart';
import '../move_word_select.dart';

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
              showCupertinoModalPopup(
                context: context,
                builder: (context) => ChangeSerializableWordsList(
                  favoriteWordModel: widget.model,
                ),
              );
            },
            backgroundColor: CupertinoColors.systemBlue,
            icon: CupertinoIcons.eye,
          ),
          SlidableAction(
            onPressed: (context) {
              showCupertinoModalPopup(context: context, builder: (_) => MoveWordSelect(wordNr: widget.model.nr, oldCollectionId: widget.model.collectionId));
            },
            backgroundColor: CupertinoColors.systemIndigo,
            icon: CupertinoIcons.arrow_turn_up_right,
          ),
          SlidableAction(
            onPressed: (context) {
              // Удалить слово из избранного
            },
            backgroundColor: CupertinoColors.systemRed,
            icon: CupertinoIcons.delete,
          ),
        ],
      ),
      child: CupertinoListTile(
        padding: AppStyles.mardingWithoutBottom,
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
        subtitle: SerializableDetailWordsList(
          translation: widget.model.translation,
          serializableIndex: widget.model.serializableIndex,
        ),
      ),
    );
  }
}
