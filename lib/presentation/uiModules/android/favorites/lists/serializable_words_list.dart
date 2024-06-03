import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/strings/app_strings.dart';
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
    final ColorScheme appColors = Theme.of(context).colorScheme;
    List<String> translationLines = wordModel.translation.split('\\n');
    return Column(
      children: [
        const SizedBox(height: 14),
        const Text(
          AppStrings.selectOne,
          style: TextStyle(fontSize: 25, fontFamily: 'SF Pro'),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.separated(
              itemCount: translationLines.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: AppStyles.mardingSymmetricHor,
                  visualDensity: const VisualDensity(vertical: -4),
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
                  trailing: Icon(
                    Icons.bookmark_outline_rounded,
                    color: appColors.primary,
                    size: 30,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 16, endIndent: 16);
              },
            ),
          ),
        ),
      ],
    );
  }
}
