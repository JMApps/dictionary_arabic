import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
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
    List<String> translationLines = favoriteWordModel.translation.split('\\n');
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text(AppStrings.change),
        previousPageTitle: AppStrings.close,
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: translationLines.length,
            itemBuilder: (BuildContext context, int index) {
              return CupertinoListTile(
                padding: AppStyles.mainMarding,
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
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                    color: CupertinoColors.systemBlue,
                  ),
              );
            },
          ),
        ),
      ),
    );
  }
}
