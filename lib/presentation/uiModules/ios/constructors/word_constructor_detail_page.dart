import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConstructorModeState(_constructorController),
        ),
      ],
      child: Consumer<ConstructorModeState>(
        builder: (BuildContext context, constructorModeState, _) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: Text(widget.collectionModel.title),
              previousPageTitle: AppStrings.toBack,
              trailing: constructorModeState.getIsReset
                  ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.refresh_bold),
                      onPressed: () {
                        constructorModeState.resetConstructor;
                      },
                    )
                  : const SizedBox(),
            ),
            child: FutureBuilder(
              future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
                collectionId: widget.collectionModel.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  constructorModeState.setWords = snapshot.data!;
                  return SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _constructorController,
                            itemCount: constructorModeState.getWords.length,
                            itemBuilder: (context, index) {
                              final FavoriteDictionaryEntity wordModel = constructorModeState.getWords[index];
                              return ConstructorItem(wordModel: wordModel);
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
                                constructorModeState.inCorrectAnswer.toString(),
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: CupertinoColors.systemRed,
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
                            dotColor: CupertinoColors.systemBlue.withOpacity(0.35),
                            activeDotColor: CupertinoColors.systemBlue,
                            dotWidth: 10,
                            dotHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 21),
                      ],
                    ),
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
