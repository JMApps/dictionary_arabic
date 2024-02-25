import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import 'lists/change_serializable_favorite_word.dart';

class FavoriteWordDetailPage extends StatelessWidget {
  const FavoriteWordDetailPage({
    super.key,
    required this.wordNumber,
  });

  final int wordNumber;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return FutureBuilder<FavoriteDictionaryEntity>(
      future: Provider.of<FavoriteWordsState>(context).fetchFavoriteWordById(favoriteWordId: wordNumber),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: appColors.inversePrimary,
                  forceElevated: true,
                  centerTitle: true,
                  floating: true,
                  title: const Text(AppStrings.word),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ChangeSerializableFavoriteWord(
                            favoriteWordModel: snapshot.data!,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: appColors.primary,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FavoriteDetailWordItem(favoriteWordModel: snapshot.data!),
                      Padding(
                        padding: AppStyles.horizontalVerticalMini,
                        child: Text(
                          AppStrings.cognates,
                          style: TextStyle(
                            fontSize: 20,
                            color: appColors.primary,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ),
                      FutureBuilder<List<DictionaryEntity>>(
                        future: Provider.of<DefaultDictionaryState>(context, listen: false).getWordsByRoot(
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
                                final DictionaryEntity wordModel = wordRootsSnapshot.data![index];
                                return RootWordItem(
                                  wordModel: wordModel,
                                  index: index,
                                );
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
          );
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
