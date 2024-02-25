import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/card_mode_state.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/flip_translation_text.dart';

class CardModeItem extends StatelessWidget {
  const CardModeItem({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final List<String> translationLines = favoriteWordModel.translation.split('\\n');
    return SafeArea(
      bottom: false,
      child: FlipCard(
        side: CardSide.FRONT,
        direction: FlipDirection.HORIZONTAL,
        front: Provider.of<CardModeState>(context).getCardMode
            ? Container(
                padding: AppStyles.mainMarding,
                alignment: Alignment.center,
                child: Text(
                  favoriteWordModel.arabicWord,
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Uthmanic',
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: AppStyles.mainMarding,
                    child: favoriteWordModel.serializableIndex != -1
                        ? FlipTranslationText(
                            translation: translationLines[favoriteWordModel.serializableIndex])
                        : FlipTranslationText(translation: favoriteWordModel.translation),
                  ),
                ),
              ),
        back: Provider.of<CardModeState>(context).getCardMode
            ? Container(
                alignment: Alignment.center,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: AppStyles.mainMarding,
                    child: favoriteWordModel.serializableIndex != -1
                        ? FlipTranslationText(translation: translationLines[favoriteWordModel.serializableIndex])
                        : FlipTranslationText(translation: favoriteWordModel.translation),
                  ),
                ),
              )
            : Container(
                padding: AppStyles.mainMarding,
                alignment: Alignment.center,
                child: Text(
                  favoriteWordModel.arabicWord,
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Uthmanic',
                  ),
                ),
              ),
      ),
    );
  }
}
