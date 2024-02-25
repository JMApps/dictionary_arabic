import 'package:flutter/material.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../widgets/favorite_translation_text.dart';

class SerializableDetailFavoriteWord extends StatelessWidget {
  const SerializableDetailFavoriteWord({
    super.key,
    required this.translation,
    required this.serializableIndex,
  });

  final String translation;
  final int serializableIndex;

  @override
  Widget build(BuildContext context) {
    List<String> translationLines = translation.split('\\n');
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: translationLines.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: AppStyles.mardingOnlyTop,
          child: FavoriteTranslationText(
            translation: translationLines[index],
            index: index,
            serializableIndex: serializableIndex,
          ),
        );
      },
    );
  }
}
