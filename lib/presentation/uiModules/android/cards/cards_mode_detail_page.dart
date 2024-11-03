import 'package:arabic/core/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../data/state/card_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import 'items/card_mode_item.dart';

class CardsModeDetailPage extends StatefulWidget {
  const CardsModeDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<CardsModeDetailPage> createState() => _CardsModeDetailPageState();
}

class _CardsModeDetailPageState extends State<CardsModeDetailPage> {
  final PageController _cardPageController = PageController();
  late final Future<List<FavoriteDictionaryEntity>> _futureFavoriteDictionaries;

  @override
  void initState() {
    super.initState();
    _futureFavoriteDictionaries = Provider.of<FavoriteWordsState>(context, listen: false).fetchFavoriteWordsByCollectionId(
      collectionId: widget.collectionModel.id,
    );
  }

  @override
  void dispose() {
    _cardPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardModeState(),
        ),
      ],
      child: Consumer<CardModeState>(
        builder: (BuildContext context, cardModeState, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColors.inversePrimary,
              centerTitle: true,
              title: Text(widget.collectionModel.title),
              actions: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    cardModeState.setCardMode = !cardModeState.getCardMode;
                  },
                  icon: Icon(
                    Icons.loop,
                    color: appColors.primary,
                  ),
                ),
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
              future: _futureFavoriteDictionaries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!.shuffle();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _cardPageController,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final FavoriteDictionaryEntity favoriteWordModel = snapshot.data![index];
                            return CardModeItem(favoriteWordModel: favoriteWordModel);
                          },
                        ),
                      ),
                      Padding(
                        padding: AppStyles.mardingSymmetricHor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _cardPageController.previousPage(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeInToLinear,
                                );
                              },
                              icon: Icon(
                                Icons.arrow_circle_left_outlined,
                                size: 50,
                                color: appColors.inversePrimary,
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: _cardPageController,
                              count: snapshot.data!.length,
                              effect: ScrollingDotsEffect(
                                maxVisibleDots: 5,
                                dotColor: appColors.primary.withOpacity(0.25),
                                activeDotColor: appColors.primary,
                                dotWidth: 10,
                                dotHeight: 10,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 50,
                                color: appColors.inversePrimary,
                              ),
                              onPressed: () {
                                _cardPageController.nextPage(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeInToLinear,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
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
