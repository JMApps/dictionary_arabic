import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/translation_text.dart';

class ChangeSerializableFavoriteWord extends StatelessWidget {
  const ChangeSerializableFavoriteWord({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    List<String> translationLines = favoriteWordModel.translation.split('\\n');
    return Scrollbar(
      child: ListView.separated(
        itemCount: translationLines.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () async {
              if (favoriteWordModel.serializableIndex != index) {
                Navigator.of(context).pop();
                await Provider.of<FavoriteWordsState>(context, listen: false).changeFavoriteWord(
                  favoriteWordId: favoriteWordModel.wordNumber,
                  serializableIndex: index,
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            title: TranslationText(translation: translationLines[index]),
            trailing: Icon(
              favoriteWordModel.serializableIndex == index
                  ? Icons.bookmark
                  : Icons.bookmark_outline_rounded,
              color: appColors.primary,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(indent: 16, endIndent: 16);
        },
      ),
    );
  }
}
