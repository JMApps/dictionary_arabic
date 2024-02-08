import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/constructor_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/flip_translation_text.dart';

class WordsConstructorDetailPage extends StatefulWidget {
  const WordsConstructorDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<WordsConstructorDetailPage> createState() => _WordsConstructorDetailPageState();
}

class _WordsConstructorDetailPageState extends State<WordsConstructorDetailPage> {
  final PageController _cardPageController = PageController();
  List<String> _letters = [];

  @override
  Widget build(BuildContext context) {
    final double thirdHeightSize = MediaQuery.of(context).size.height / 4;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConstructorModeState(),
        ),
      ],
      child: Consumer<ConstructorModeState>(
        builder: (BuildContext context, ConstructorModeState constructorModeState, _) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.collectionModel.title),
              previousPageTitle: AppStrings.toBack,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Icon(CupertinoIcons.question_circle),
              ),
            ),
            child: FutureBuilder(
              future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
                collectionId: widget.collectionModel.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _cardPageController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final FavoriteDictionaryEntity model = snapshot.data![index];
                            _letters = model.arabicWord.split('');
                            final List<String> translationLines = model.translation.split('\\n');
                            return SafeArea(
                              bottom: false,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: thirdHeightSize,
                                    child: Center(
                                      child: SingleChildScrollView(
                                        padding: AppStyles.mainMarding,
                                        child: model.serializableIndex != -1
                                            ? FlipTranslationText(translation: translationLines[model.serializableIndex])
                                            : FlipTranslationText(translation: model.translation),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Container(
                                    padding: AppStyles.mainMarding,
                                    alignment: Alignment.center,
                                    child: Text(
                                      constructorModeState.getEndWord,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontFamily: 'Uthmanic',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Wrap(
                                    spacing: 7,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: _letters.map((letter) {
                                      return CupertinoButton(
                                        onPressed: constructorModeState.getEndWord.length < model.arabicWord.length ? () => constructorModeState.setEndWord = letter : null,
                                        child: Text(
                                          letter,
                                          style: const TextStyle(
                                            fontSize: 50,
                                            fontFamily: 'Uthmanic',
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 7),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 7),
                      CupertinoButton(
                        child: const Text(
                          AppStrings.reset,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        onPressed: () {
                          constructorModeState.getResetWord;
                        },
                      ),
                      const SizedBox(height: 7),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _cardPageController,
                          count: snapshot.data!.length,
                          effect: ScrollingDotsEffect(
                            maxVisibleDots: 5,
                            dotColor: CupertinoColors.systemBlue.withOpacity(0.35),
                            activeDotColor: CupertinoColors.systemBlue,
                            dotWidth: 10,
                            dotHeight: 10,
                          ),
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
          );
        },
      ),
    );
  }
}
