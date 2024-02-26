import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/constructor_mode_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import 'items/constructor_item.dart';

class WordConstructorDetailPage extends StatefulWidget {
  const WordConstructorDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<WordConstructorDetailPage> createState() => _WordConstructorDetailPageState();
}

class _WordConstructorDetailPageState extends State<WordConstructorDetailPage> {
  final PageController _constructorController = PageController();

  @override
  void dispose() {
    _constructorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConstructorModeState(_constructorController),
        ),
      ],
      child: Consumer<ConstructorModeState>(
        builder: (BuildContext context, constructorModeState, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColors.inversePrimary,
              centerTitle: true,
              title: Text(widget.collectionModel.title),
              actions: [
                constructorModeState.getIsReset
                    ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.replay),
                  onPressed: () {
                    constructorModeState.resetConstructor;
                  },
                ) : const SizedBox(),
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
            body: FutureBuilder(
              future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
                collectionId: widget.collectionModel.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  constructorModeState.setWords = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _constructorController,
                          itemCount: constructorModeState.getWords.length,
                          itemBuilder: (context, index) {
                            final FavoriteDictionaryEntity favoriteWordModel = constructorModeState.getWords[index];
                            return ConstructorItem(favoriteWordModel: favoriteWordModel);
                          },
                          onPageChanged: (int pageIndex) {
                            constructorModeState.setPageIndex = pageIndex;
                          },
                        ),
                      ),
                      Padding(
                        padding: AppStyles.mainMarding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              constructorModeState.correctAnswer.toString(),
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
                              constructorModeState.inCorrectAnswer.toString(),
                              style: const TextStyle(
                                fontSize: 35,
                                color: Colors.red,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _constructorController,
                        count: constructorModeState.getWords.length,
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
