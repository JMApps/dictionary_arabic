import 'package:flutter/cupertino.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/args/word_favorite_collection_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/translation_text.dart';

class SerializableWordsList extends StatelessWidget {
  const SerializableWordsList({
    super.key,
    required this.wordModel,
  });

  final DictionaryEntity wordModel;

  @override
  Widget build(BuildContext context) {
    List<String> translationLines = wordModel.translation.split('\\n');
    return CupertinoScrollbar(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: translationLines.length,
        itemBuilder: (BuildContext context, int index) {
          return CupertinoListTile(
            padding: AppStyles.mainMarding,
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.favoriteWordSelectionCollectionPage,
                arguments: WordFavoriteCollectionArgs(
                  wordModel: wordModel,
                  serializableIndex: index,
                ),
              );
            },
            title: TranslationText(translation: translationLines[index]),
            trailing: const Icon(
                CupertinoIcons.bookmark,
                color: CupertinoColors.systemBlue,
              ),
          );
        },
      ),
    );
  }
}
