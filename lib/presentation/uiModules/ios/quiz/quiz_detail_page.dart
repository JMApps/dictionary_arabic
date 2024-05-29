import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuizModeState(_quizController),
        ),
      ],
      child: Consumer<QuizModeState>(
        builder: (BuildContext context, quizModeState, _) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.collectionModel.title),
              previousPageTitle: AppStrings.toBack,
              trailing: quizModeState.getIsReset
                  ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.refresh_bold),
                      onPressed: () {
                        quizModeState.resetQuiz;
                      },
                    )
                  : const SizedBox(),
            ),
            child: SafeArea(
              bottom: false,
              child: FutureBuilder<List<FavoriteDictionaryEntity>>(
                future: Provider.of<FavoriteWordsState>(context, listen: false).fetchFavoriteWordsByCollectionId(
                  collectionId: widget.collectionModel.id,
                ),
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
                              final FavoriteDictionaryEntity wordModel = quizModeState.getWords[pageIndex];
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 21),
                                    Text(
                                      wordModel.arabicWord,
                                      style: const TextStyle(
                                        fontSize: 60,
                                        fontFamily: 'Uthmanic',
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 7),
                                    FutureBuilder(
                                      future: Provider.of<DefaultDictionaryState>(context, listen: false).fetchWordsByQuiz(wordNumber: wordModel.wordNumber),
                                      builder: (context, quizSnapshot) {
                                        if (quizSnapshot.hasData) {
                                          return QuizItem(
                                            wordNumber: wordModel.wordNumber,
                                            pageIndex: pageIndex,
                                            quizSnapshot: quizSnapshot,
                                          );
                                        } else {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                      },
                                    ),
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
                                  color: CupertinoColors.systemGreen,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                              const Text(
                                ' : ',
                                style: TextStyle(
                                  fontSize: 35,
                                  color: CupertinoColors.systemBlue,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                              Text(
                                quizModeState.inCorrectAnswer.toString(),
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: CupertinoColors.systemRed,
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
                            dotColor: CupertinoColors.systemBlue.withOpacity(0.35),
                            activeDotColor: CupertinoColors.systemBlue,
                            dotWidth: 10,
                            dotHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 21),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
