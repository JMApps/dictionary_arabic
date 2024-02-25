import 'package:flutter/cupertino.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../widgets/favorite_translation_text.dart';

class SerializableDetailWordsList extends StatelessWidget {
  const SerializableDetailWordsList({
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
          padding: AppStyles.mardingOnlyBottom,
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
