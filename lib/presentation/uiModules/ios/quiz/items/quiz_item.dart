import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/default_dictionary_state.dart';
import '../../../../../data/state/quiz_mode_state.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/error_data_text.dart';
import '../../widgets/quiz_translation_text.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({
    super.key,
    required this.wordNumber,
    required this.pageIndex,
  });

  final int wordNumber;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizModeState>(
      builder: (BuildContext context, QuizModeState quizModeState, _) {
        return FutureBuilder<List<DictionaryEntity>>(
          future: Provider.of<DefaultDictionaryState>(context).fetchWordsByQuiz(wordNr: wordNumber),
          builder: (context, quizSnapshot) {
            if (quizSnapshot.hasData) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: quizSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final FavoriteDictionaryEntity wordModel = quizModeState.getWords[pageIndex];
                  final DictionaryEntity quizModel = quizSnapshot.data![index];
                  return CupertinoListSection(
                    topMargin: 0,
                    margin: EdgeInsets.zero,
                    header: CupertinoButton(
                      onPressed: quizModeState.getIsClick
                          ? () {
                        quizModeState.setAnswerState = wordModel.articleId.contains(quizModel.articleId);
                      }
                          : null,
                      padding: EdgeInsets.zero,
                      child: QuizTranslationText(
                        translation: quizModel.translation,
                      ),
                    ),
                    footer: Container(
                      margin: AppStyles.mardingSymmetricVerMini,
                      height: 1,
                      color: CupertinoColors.systemGrey,
                    ),
                  );
                },
              );
            } else if (quizSnapshot.hasError) {
              return ErrorDataText(errorText: quizSnapshot.error.toString());
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        );
      },
    );
  }
}
