import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/default_dictionary_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../search/items/root_word_item.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import 'items/favorite_detail_word_item.dart';

class FavoriteWordDetailPage extends StatelessWidget {
  const FavoriteWordDetailPage({
    super.key,
    required this.favoriteWordNumber,
  });

  final int favoriteWordNumber;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FavoriteDictionaryEntity>(
      future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordById(favoriteWordId: favoriteWordNumber),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: const Text(AppStrings.word),
              previousPageTitle: AppStrings.close,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Share.share(
                    snapshot.data!.wordContent(),
                    sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
                  );
                },
                child: const Icon(CupertinoIcons.share),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: CupertinoScrollbar(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FavoriteDetailWordItem(favoriteWordModel: snapshot.data!),
                          Container(
                            padding: AppStyles.mainMardingMini,
                            child: const Text(
                              AppStrings.cognates,
                              style: TextStyle(
                                fontSize: 20,
                                color: CupertinoColors.systemBlue,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ),
                          FutureBuilder<List<DictionaryEntity>>(
                            future: Provider.of<DefaultDictionaryState>(context).getWordsByRoot(
                              wordRoot: snapshot.data!.root,
                              excludedId: snapshot.data!.wordNumber,
                            ),
                            builder: (context, wordRootsSnapshot) {
                              if (wordRootsSnapshot.hasData && wordRootsSnapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wordRootsSnapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final DictionaryEntity model = wordRootsSnapshot.data![index];
                                    return RootWordItem(wordModel: model);
                                  },
                                );
                              } else {
                                return const DataText(text: AppStrings.rootIsEmpty);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
