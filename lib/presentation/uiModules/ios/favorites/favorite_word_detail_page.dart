import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import '../widgets/word_item.dart';
import 'items/favorite_detail_word_item.dart';

class FavoriteWordDetailPage extends StatefulWidget {
  const FavoriteWordDetailPage({
    super.key,
    required this.favoriteWordNr,
  });

  final int favoriteWordNr;

  @override
  State<FavoriteWordDetailPage> createState() => _FavoriteWordDetailPageState();
}

class _FavoriteWordDetailPageState extends State<FavoriteWordDetailPage> {
  final DefaultDictionaryUseCase _dictionaryUseCase = DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FavoriteDictionaryEntity>(
      future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordById(favoriteWordId: widget.favoriteWordNr),
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
                          FavoriteDetailWordItem(model: snapshot.data!),
                          const Padding(
                            padding: AppStyles.mainMardingMini,
                            child: Text(
                              AppStrings.cognates,
                              style: TextStyle(
                                fontSize: 20,
                                color: CupertinoColors.systemBlue,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ),
                          FutureBuilder<List<DictionaryEntity>>(
                            future: _dictionaryUseCase.fetchWordsByRoot(
                              wordRoot: snapshot.data!.root,
                              excludedId: snapshot.data!.nr,
                            ),
                            builder: (context, wordRootsSnapshot) {
                              if (wordRootsSnapshot.hasData && wordRootsSnapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: wordRootsSnapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final DictionaryEntity model = wordRootsSnapshot.data![index];
                                    return WordItem(model: model, index: index);
                                  },
                                );
                              } else {
                                return const DataText(
                                    text: AppStrings.rootIsEmpty);
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
