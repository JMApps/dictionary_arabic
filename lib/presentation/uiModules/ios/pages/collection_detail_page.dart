import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../../../../domain/entities/favorite_dictionary_entity.dart';
import '../items/favorite_word_item.dart';
import '../widgets/error_data_text.dart';
import 'favorite_words_is_empty_page.dart';
import 'search_words_page.dart';

class CollectionDetailPage extends StatefulWidget {
  const CollectionDetailPage({
    super.key,
    required this.collectionModel,
  });

  final CollectionEntity collectionModel;

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  final TextEditingController _collectionsController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoriteWordsState(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (!focusNode.hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: CupertinoPageScaffold(
          child: Consumer<FavoriteWordsState>(
            builder: (context, favoriteWordsState, _) {
              return FutureBuilder<List<FavoriteDictionaryEntity>>(
                future: favoriteWordsState.fetchFavoriteWordsByCollectionId(
                  collectionId: widget.collectionModel.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return CustomScrollView(
                      slivers: [
                        CupertinoSliverNavigationBar(
                          stretch: true,
                          middle: Text(widget.collectionModel.title),
                          previousPageTitle: AppStrings.toBack,
                          largeTitle: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CupertinoSearchTextField(
                              onChanged: (value) {
                                // Поиск слов
                              },
                              controller: _collectionsController,
                              placeholder: AppStrings.searchWords,
                            ),
                          ),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Text(
                              AppStrings.add,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => const SearchWordsPage(),
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CupertinoListSection.insetGrouped(
                            children: [
                              ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final FavoriteDictionaryEntity model =
                                  snapshot.data![index];
                                  return FavoriteWordItem(
                                    model: model,
                                    index: index,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return ErrorDataText(errorText: snapshot.error.toString());
                  } else {
                    return FavoriteWordsIsEmptyPage(
                      collectionTitle: widget.collectionModel.title,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
