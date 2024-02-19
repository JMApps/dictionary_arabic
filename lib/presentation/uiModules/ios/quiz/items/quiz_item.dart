import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/quiz_mode_state.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/quiz_translation_text.dart';

class QuizItem extends StatefulWidget {
  const QuizItem({
    super.key,
    required this.wordNumber,
    required this.pageIndex,
    required this.quizSnapshot,
  });

  final int wordNumber;
  final int pageIndex;
  final AsyncSnapshot quizSnapshot;

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  late final List<DictionaryEntity> _words;

  @override
  void initState() {
    super.initState();
    _words = widget.quizSnapshot.data!;
    _words.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizModeState>(
      builder: (BuildContext context, QuizModeState quizModeState, _) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _words.length,
          itemBuilder: (context, index) {
            final FavoriteDictionaryEntity wordModel = quizModeState.getWords[widget.pageIndex];
            final DictionaryEntity quizModel = _words[index];
            CupertinoDynamicColor lineColor;
            if (quizModeState.getIsClick) {
              lineColor = CupertinoColors.secondarySystemFill;
            } else {
              if (wordModel.articleId.contains(quizModel.articleId) && quizModeState.getAnswerIndex != -1) {
                lineColor = CupertinoColors.systemGreen;
                HapticFeedback.lightImpact();
              } else {
                lineColor = index == quizModeState.getAnswerIndex
                    ? CupertinoColors.systemRed
                    : CupertinoColors.secondarySystemFill;
                HapticFeedback.heavyImpact();
              }
            }
            return CupertinoListSection.insetGrouped(
              margin: AppStyles.mainMardingMini,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInToLinear,
                  decoration: BoxDecoration(
                    color: lineColor,
                  ),
                  child: CupertinoListTile(
                    padding: AppStyles.mainMarding,
                    onTap: quizModeState.getIsClick
                        ? () {
                            quizModeState.setAnswerState(
                              answer: wordModel.articleId.contains(quizModel.articleId),
                              clickIndex: index,
                            );
                          }
                        : null,
                    title: QuizTranslationText(
                      translation: quizModel.translation,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
