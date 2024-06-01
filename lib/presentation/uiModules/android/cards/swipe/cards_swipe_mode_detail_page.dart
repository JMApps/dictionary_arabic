import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/state/card_mode_state.dart';
import '../../../../../../data/state/favorite_words_state.dart';
import '../../../../../../domain/entities/collection_entity.dart';
import '../../../../../../domain/entities/favorite_dictionary_entity.dart';
import 'items/card_swipe_item.dart';
import 'items/card_swipe_item_tr.dart';

class CardsSwipeModeDetailPage extends StatefulWidget {
  const CardsSwipeModeDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<CardsSwipeModeDetailPage> createState() => _CardsSwipeModeDetailPageState();
}

class _CardsSwipeModeDetailPageState extends State<CardsSwipeModeDetailPage> {
  final CardSwiperController _cardSwiperController = CardSwiperController();

  @override
  void dispose() {
    _cardSwiperController.dispose();
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
              future: Provider.of<FavoriteWordsState>(context, listen: false).fetchFavoriteWordsByCollectionId(
                collectionId: widget.collectionModel.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 5,
                        child: CardSwiper(
                          controller: _cardSwiperController,
                          isLoop: false,
                          cardsCount: snapshot.data!.length,
                          cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                            return Provider.of<CardModeState>(context).getCardMode
                                ? CardSwipeItem(favoriteWordModel: snapshot.data![index])
                                : CardSwipeItemTr(favoriteWordModel: snapshot.data![index]);
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _cardSwiperController.moveTo(0);
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 35,
                        tooltip: AppStrings.reset,
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
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
