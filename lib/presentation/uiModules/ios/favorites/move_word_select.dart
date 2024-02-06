import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/favorite_words_state.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../collections/dialogs/add_collection_dialog.dart';
import '../main/widgets/add_collection_button.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';

class MoveWordSelect extends StatefulWidget {
  const MoveWordSelect({
    super.key,
    required this.wordNr,
    required this.oldCollectionId,
  });

  final int wordNr;
  final int oldCollectionId;

  @override
  State<MoveWordSelect> createState() => _MoveWordSelectState();
}

class _MoveWordSelectState extends State<MoveWordSelect> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _collectionsController = TextEditingController();
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _recentCollections = [];

  @override
  void dispose() {
    _focusNode.dispose();
    _collectionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchQueryState(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (!_focusNode.hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          child: Consumer<SearchQueryState>(
            builder: (BuildContext context, SearchQueryState query, _) {
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    stretch: true,
                    middle: const Text(AppStrings.selectCollection),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(AppStrings.add),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return const AddCollectionDialog();
                          },
                        );
                      },
                    ),
                    previousPageTitle: AppStrings.toBack,
                    largeTitle: Padding(
                      padding: AppStyles.mardingOnlyRight,
                      child: CupertinoSearchTextField(
                        controller: _collectionsController,
                        placeholder: AppStrings.searchCollections,
                        onChanged: (value) {
                          query.setQuery = value;
                        },
                      ),
                    ),
                  ),
                  FutureBuilder<List<CollectionEntity>>(
                    future: Provider.of<CollectionsState>(context).fetchAllButOneCollections(collectionId: widget.oldCollectionId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        _collections = snapshot.data!;
                        _recentCollections = query.getQuery.isEmpty
                            ? _collections
                            : _collections
                            .where((element) => element.title.toLowerCase()
                            .contains(query.getQuery.toLowerCase())).toList();
                        return SliverToBoxAdapter(
                          child: CupertinoListSection.insetGrouped(
                            margin: AppStyles.mardingWithoutBottomMini,
                            footer: const SizedBox(height: 14),
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _recentCollections.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final CollectionEntity collectionModel = _recentCollections[index];
                                  return CupertinoListTile(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      await Provider.of<FavoriteWordsState>(context, listen: false).moveFavoriteWord(wordNr: widget.wordNr, oldCollectionId: widget.oldCollectionId, collectionId: collectionModel.id);
                                    },
                                    title: Text(collectionModel.title),
                                    trailing: const Icon(CupertinoIcons.forward),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: ErrorDataText(
                            errorText: snapshot.error.toString(),
                          ),
                        );
                      } else {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const DataText(text: AppStrings.collectionButOneIsEmpty),
                              Transform.scale(
                                scale: 2,
                                child: const AddCollectionButton(),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
