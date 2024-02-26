import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/constructor_mode_state.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/flip_translation_text.dart';

class ConstructorItem extends StatefulWidget {
  const ConstructorItem({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  State<ConstructorItem> createState() => _ConstructorItemState();
}

class _ConstructorItemState extends State<ConstructorItem> {
  late final List<String> _letters;
  late final List<String> _translationLines;

  @override
  void initState() {
    super.initState();
    _letters = widget.favoriteWordModel.arabicWord.split('');
    _translationLines = widget.favoriteWordModel.translation.split('\\n');
    _letters.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Consumer<ConstructorModeState>(
      builder: (BuildContext context, constructorState, _) {
        return Center(
          child: SingleChildScrollView(
            padding: AppStyles.mainMarding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.favoriteWordModel.serializableIndex != -1
                    ? FlipTranslationText(translation: _translationLines[widget.favoriteWordModel.serializableIndex])
                    : FlipTranslationText(translation: widget.favoriteWordModel.translation),
                const SizedBox(height: 16),
                Text(
                  constructorState.getInputWord,
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: 'Uthmanic',
                    color: appColors.primary,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: _letters.map((letter) {
                    return OutlinedButton(
                      onPressed: constructorState.getIsClick
                          ? () => constructorState.setInputLetters = letter
                          : null,
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'SF Pro Regular',
                          height: 2
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                IconButton(
                  onPressed: constructorState.getIsClick
                      ? () => constructorState.removeLastLetter()
                      : null,
                  icon: Icon(
                    Icons.backspace_outlined,
                    color: appColors.error,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
