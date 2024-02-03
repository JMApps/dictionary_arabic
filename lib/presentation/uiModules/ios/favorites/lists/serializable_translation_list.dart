import 'package:flutter/cupertino.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/args/word_favorite_collection_args.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/translation_text.dart';

class SerializableTranslationList extends StatelessWidget {
  const SerializableTranslationList({
    super.key,
    required this.model,
  });

  final DictionaryEntity model;

  @override
  Widget build(BuildContext context) {
    List<String> translationLines = model.translation.split('\\n');

    return CupertinoScrollbar(
      child: ListView.builder(
        padding: AppStyles.mardingWithoutBottom,
        itemCount: translationLines.length,
        itemBuilder: (BuildContext context, int index) {
          return CupertinoListTile(
            padding: AppStyles.mardingOnlyBottom,
            title: TranslationText(translation: translationLines[index]),
            trailing: CupertinoButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.wordFavoriteCollectionPage,
                  arguments: WordFavoriteCollectionArgs(
                    wordModel: model,
                    serializableIndex: index,
                  ),
                );
              },
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.bookmark,
                color: CupertinoColors.systemBlue,
              ),
            ),
          );
        },
      ),
    );
  }
}
