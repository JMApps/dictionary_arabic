import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/error_data_text.dart';
import '../widgets/quiz_translation_text.dart';

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
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.collectionModel.title),
        previousPageTitle: AppStrings.toBack,
      ),
      child: SafeArea(
        bottom: false,
        child: FutureBuilder<List<FavoriteDictionaryEntity>>(
          future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(collectionId: widget.collectionModel.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _quizController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final FavoriteDictionaryEntity model = snapshot.data![index];
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 21),
                              Text(
                                model.arabicWord,
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontFamily: 'Uthmanic',
                                ),
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 7),
                              FutureBuilder<List<DictionaryEntity>>(
                                future: Provider.of<DefaultDictionaryState>(context).fetchWordsByQuiz(wordNr: model.nr),
                                builder: (context, quizSnapshot) {
                                  if (quizSnapshot.hasData) {
                                    quizSnapshot.data!.shuffle();
                                  }
                                  if (quizSnapshot.hasData) {
                                    return ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: quizSnapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final DictionaryEntity quizModel = quizSnapshot.data![index];
                                        return CupertinoListSection(
                                          topMargin: 0,
                                          margin: EdgeInsets.zero,
                                          header: CupertinoButton(
                                            onPressed: () {},
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
                                  } else if (snapshot.hasError) {
                                    return ErrorDataText(errorText: snapshot.error.toString());
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
                      onPageChanged: (int pageIndex) {

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
                          0.toString(),
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
                            color: CupertinoColors.systemGrey,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        Text(
                          0.toString(),
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
                    count: snapshot.data!.length,
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
  }
}
