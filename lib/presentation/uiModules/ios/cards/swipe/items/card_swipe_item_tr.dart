import 'package:flutter/cupertino.dart';

import '../../../../../../core/styles/app_styles.dart';
import '../../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../../widgets/flip_translation_text.dart';

class CardSwipeItemTr extends StatelessWidget {
  const CardSwipeItemTr({super.key, required this.favoriteWordModel});

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final List<String> translationLines = favoriteWordModel.translation.split('\\n');
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? CupertinoColors.darkBackgroundGray : CupertinoColors.white,
          borderRadius: AppStyles.mainBorder,
          boxShadow: const [
            BoxShadow(spreadRadius: 0.25, blurRadius: 1),
          ],
        ),
        child: favoriteWordModel.serializableIndex != -1
            ? FlipTranslationText(translation: translationLines[favoriteWordModel.serializableIndex])
            : FlipTranslationText(translation: favoriteWordModel.translation),
      ),
    );
  }
}
