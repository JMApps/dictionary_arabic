import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/constructor_mode_state.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/flip_translation_text.dart';

class ConstructorItem extends StatefulWidget {
  const ConstructorItem({super.key, required this.wordModel,});

  final FavoriteDictionaryEntity wordModel;

  @override
  State<ConstructorItem> createState() => _ConstructorItemState();
}

class _ConstructorItemState extends State<ConstructorItem> {
  late final List<String> _letters;
  @override
  void initState() {
    super.initState();
    _letters = widget.wordModel.arabicWord.split('');
    _letters.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> translationLines = widget.wordModel.translation.split('\\n');
    return Consumer<ConstructorModeState>(
      builder: (BuildContext context, constructorState, _) {
        return Center(
          child: SingleChildScrollView(
            padding: AppStyles.mainMarding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.wordModel.serializableIndex != -1
                    ? FlipTranslationText(translation: translationLines[widget.wordModel.serializableIndex])
                    : FlipTranslationText(translation: widget.wordModel.translation),
                const SizedBox(height: 28),
                Text(
                  constructorState.getInputWord,
                  style: const TextStyle(
                    fontSize: 50,
                    fontFamily: 'Uthmanic',
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                Wrap(
                  spacing: 7,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: _letters.map((letter) {
                    return CupertinoButton(
                      onPressed: constructorState.getInputWord.length < widget.wordModel.arabicWord.length
                          ? () => constructorState.setInputLetters = letter : null,
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'SF Pro Regular',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
                CupertinoButton(
                  onPressed: constructorState.getInputWord.length < widget.wordModel.arabicWord.length
                      ? () {
                    constructorState.removeLastLetter();
                  } : null,
                  child: const Icon(
                    CupertinoIcons.delete_right,
                    color: CupertinoColors.systemRed,
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
