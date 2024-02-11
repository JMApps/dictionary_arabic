import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/strings/app_strings.dart';
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
          create: (_) => ConstructorModeState(),
        ),
      ],
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.collectionModel.title),
          previousPageTitle: AppStrings.toBack,
        ),
        child: FutureBuilder(
          future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordsByCollectionId(
            collectionId: widget.collectionModel.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        controller: _constructorController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final FavoriteDictionaryEntity wordModel = snapshot.data![index];
                          return ConstructorItem(wordModel: wordModel);
                        },
                      ),
                    ),
                    const SizedBox(height: 7),
                    SmoothPageIndicator(
                      controller: _constructorController,
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
                ),
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
