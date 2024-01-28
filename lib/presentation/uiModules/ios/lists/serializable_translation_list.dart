import 'package:arabic/core/styles/app_styles.dart';
import 'package:arabic/domain/entities/dictionary_entity.dart';
import 'package:arabic/presentation/uiModules/ios/widgets/translation_double.dart';
import 'package:flutter/cupertino.dart';

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
            padding: const EdgeInsets.only(bottom: 14),
            title: TranslationDouble(translation: translationLines[index]),
            leading: const Icon(CupertinoIcons.bookmark),
          );
        },
      ),
    );
  }
}
