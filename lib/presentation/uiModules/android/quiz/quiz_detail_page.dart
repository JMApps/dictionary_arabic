import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../data/state/quiz_mode_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import 'items/quiz_item.dart';

class QuizDetailPage extends StatefulWidget {
  const QuizDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  final PageController _quizController = PageController();

  @override
  void dispose() {
    _quizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuizModeState(_quizController),
        ),
      ],
      child: Consumer<QuizModeState>(
        builder: (BuildContext context, quizModeState, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColors.inversePrimary,
              centerTitle: true,
              title: Text(widget.collectionModel.title),
              actions: [
                quizModeState.getIsReset
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.replay,
                          color: appColors.primary,
                        ),
                        onPressed: () => quizModeState.resetQuiz,
                      )
                    : const SizedBox(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: appColors.primary,
                  ),
                ),
              ],
            ),
            body: FutureBuilder<List<FavoriteDictionaryEntity>>(
              future: Provider.of<FavoriteWordsState>(context, listen: false)
                  .fetchFavoriteWordsByCollectionId(
                      collectionId: widget.collectionModel.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  quizModeState.setWords = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _quizController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: quizModeState.getWords.length,
                          itemBuilder: (context, pageIndex) {
                            final FavoriteDictionaryEntity wordModel =
                                quizModeState.getWords[pageIndex];
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 24),
                                  Text(
                                    wordModel.arabicWord,
                                    style: const TextStyle(
                                      fontSize: 60,
                                      fontFamily: 'Uthmanic',
                                    ),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  FutureBuilder(
                                      future:
                                          Provider.of<DefaultDictionaryState>(
                                                  context,
                                                  listen: false)
                                              .fetchWordsByQuiz(
                                                  wordNumber: wordModel.wordNumber),
                                      builder: (context, quizSnapshot) {
                                        if (quizSnapshot.hasData) {
                                          return QuizItem(
                                            wordNumber: wordModel.wordNumber,
                                            pageIndex: pageIndex,
                                            quizSnapshot: quizSnapshot,
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                ],
                              ),
                            );
                          },
                          onPageChanged: (int page) {
                            quizModeState.setPageIndex = page;
                          },
                        ),
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: AppStyles.mainMarding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              quizModeState.correctAnswer.toString(),
                              style: const TextStyle(
                                fontSize: 35,
                                color: Colors.teal,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                            const Text(
                              ' : ',
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.blue,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                            Text(
                              quizModeState.inCorrectAnswer.toString(),
                              style: const TextStyle(
                                fontSize: 35,
                                color: Colors.red,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7),
                      SmoothPageIndicator(
                        controller: _quizController,
                        count: quizModeState.getWords.length,
                        effect: ScrollingDotsEffect(
                          maxVisibleDots: 5,
                          dotColor: appColors.primary.withOpacity(0.35),
                          activeDotColor: appColors.primary,
                          dotWidth: 10,
                          dotHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 21),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
