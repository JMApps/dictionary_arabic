import 'package:arabic/presentation/uiModules/ios/cards/items/card_mode_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/card_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';

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

  @override
  void dispose() {
    _cardPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardModeState(),
        ),
      ],
      child: Consumer<CardModeState>(
        builder: (BuildContext context, cardModeState, _) {
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
                child: const Icon(CupertinoIcons.arrow_2_circlepath),
              ),
            ),
            child: FutureBuilder<List<FavoriteDictionaryEntity>>(
              future: Provider.of<FavoriteWordsState>(context, listen: false).fetchFavoriteWordsByCollectionId(
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
                            final FavoriteDictionaryEntity favoriteWordModel = snapshot.data![index];
                            return CardModeItem(favoriteWordModel: favoriteWordModel);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Icon(CupertinoIcons.arrow_left_circle, size: 50),
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
                            child: const Icon(CupertinoIcons.arrow_right_circle, size: 50),
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
