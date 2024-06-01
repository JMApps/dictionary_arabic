import 'package:flutter/material.dart';

import '../../../../../../../core/styles/app_styles.dart';
import '../../../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../../widgets/flip_translation_text.dart';

class CardSwipeItemTr extends StatelessWidget {
  const CardSwipeItemTr({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final List<String> translationLines = favoriteWordModel.translation.split('\\n');
    return SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors.secondaryContainer,
            borderRadius: AppStyles.mainBorder,
            boxShadow: const [
              BoxShadow(spreadRadius: 0.25, blurRadius: 1),
            ],
          ),
          child: favoriteWordModel.serializableIndex != -1
              ? FlipTranslationText(translation: translationLines[favoriteWordModel.serializableIndex])
              : FlipTranslationText(translation: favoriteWordModel.translation),
        ),
      ),
    );
  }
}
