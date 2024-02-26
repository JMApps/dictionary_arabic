import 'package:flutter/material.dart';
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
      builder: (BuildContext context, quizModeState, _) {
        return ListView.builder(
          padding: AppStyles.mainMarding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _words.length,
          itemBuilder: (context, index) {
            final FavoriteDictionaryEntity wordModel = quizModeState.getWords[widget.pageIndex];
            final DictionaryEntity quizModel = _words[index];
            Color lineColor;
            if (quizModeState.getIsClick) {
              lineColor = Colors.black12;
            } else {
              if (wordModel.articleId.contains(quizModel.articleId) && quizModeState.getAnswerIndex != -1) {
                lineColor = Colors.teal;
                HapticFeedback.lightImpact();
              } else {
                lineColor = index == quizModeState.getAnswerIndex
                    ? Colors.red
                    : Colors.black12;
                HapticFeedback.heavyImpact();
              }
            }
            return Container(
              margin: AppStyles.mardingOnlyBottom,
              child: InkWell(
                borderRadius: AppStyles.mainBorderMini,
                onTap: quizModeState.getIsClick ? () {
                  quizModeState.setAnswerState(answer: wordModel.articleId.contains(quizModel.articleId), clickIndex: index,);
                } : null,
                child: AnimatedContainer(
                  padding: AppStyles.mainMardingMini,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInToLinear,
                  decoration: BoxDecoration(
                    borderRadius: AppStyles.mainBorderMini,
                    border: Border.all(
                      color: lineColor,
                      width: 2,
                    ),
                  ),
                  child: QuizTranslationText(
                    translation: quizModel.translation,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
