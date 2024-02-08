import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/constructor_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/short_translation_text.dart';

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
            child: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  alwaysShowMiddle: false,
                  middle: Text(widget.collectionModel.title),
                  largeTitle: const Text('Введите слово'),
                  previousPageTitle: AppStrings.toBack,
                ),
                FutureBuilder(
                  future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
                    collectionId: widget.collectionModel.id,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PageView.builder(
                              controller: _cardPageController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final FavoriteDictionaryEntity model = snapshot.data![index];
                                _letters = model.arabicWord.split('');
                                final List<String> translationLines = model.translation.split('\\n');
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 14),
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
                                    Padding(
                                      padding: AppStyles.mardingSymmetricHor,
                                      child: Center(
                                        child: model.serializableIndex != -1
                                            ? ShortTranslationText(translation: translationLines[model.serializableIndex])
                                            : ShortTranslationText(translation: model.translation),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
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
                                              fontSize: 40,
                                              fontFamily: 'Uthmanic',
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 7),
                                    CupertinoButton(
                                      onPressed: constructorModeState.getEndWord.length != model.arabicWord.length ? () {
                                        if (constructorModeState.getEndWord.isNotEmpty) {
                                          constructorModeState.removeLastLetter();
                                        }
                                      } : null,
                                      child: const Icon(CupertinoIcons.delete_left, size: 30),
                                    ),
                                  ],
                                );
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
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
