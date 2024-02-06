import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/card_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../widgets/flip_translation_text.dart';

class CardsCollectionDetailPage extends StatefulWidget {
  const CardsCollectionDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<CardsCollectionDetailPage> createState() =>
      _CardsCollectionDetailPageState();
}

class _CardsCollectionDetailPageState extends State<CardsCollectionDetailPage> {
  final PageController _cardPageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardModeState(),
        ),
      ],
      child: Consumer<CardModeState>(
        builder: (BuildContext context, CardModeState cardModeState, _) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.collectionModel.title),
              previousPageTitle: AppStrings.toBack,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  cardModeState.setCardMode = !cardModeState.getCardMode;
                },
                child: const Icon(CupertinoIcons.arrowshape_turn_up_left_circle),
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
                            final List<String> translationLines = model.translation.split('\\n');
                            return SafeArea(
                                bottom: false,
                                child: FlipCard(
                                  side: cardModeState.getCardMode ? CardSide.FRONT : CardSide.BACK,
                                  direction: FlipDirection.HORIZONTAL,
                                  front: cardModeState.getCardMode ? Container(
                                    padding: AppStyles.mainMarding,
                                    alignment: Alignment.center,
                                    child: Text(
                                      model.arabicWord,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontFamily: 'Uthmanic',
                                      ),
                                    ),
                                  ) : Container(
                                    alignment: Alignment.center,
                                    child: CupertinoScrollbar(
                                      child: SingleChildScrollView(
                                        padding: AppStyles.mainMarding,
                                        child: model.serializableIndex != -1
                                            ? FlipTranslationText(translation: translationLines[model.serializableIndex])
                                            : FlipTranslationText(translation: model.translation),
                                      ),
                                    ),
                                  ),
                                  back: cardModeState.getCardMode ? Container(
                                    alignment: Alignment.center,
                                    child: CupertinoScrollbar(
                                      child: SingleChildScrollView(
                                        padding: AppStyles.mainMarding,
                                        child: model.serializableIndex != -1
                                            ? FlipTranslationText(translation: translationLines[model.serializableIndex])
                                            : FlipTranslationText(translation: model.translation),
                                      ),
                                    ),
                                  ) : Container(
                                    padding: AppStyles.mainMarding,
                                    alignment: Alignment.center,
                                    child: Text(
                                      model.arabicWord,
                                      style: const TextStyle(
                                        fontSize: 50,
                                        fontFamily: 'Uthmanic',
                                      ),
                                    ),
                                  ),
                                ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Icon(CupertinoIcons.arrow_left_circle, size: 35),
                            onPressed: () {
                              _cardPageController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInToLinear,
                              );
                            },
                          ),
                          SmoothPageIndicator(
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
                          CupertinoButton(
                            child: const Icon(CupertinoIcons.arrow_right_circle, size: 35),
                            onPressed: () {
                              _cardPageController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInToLinear,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
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
