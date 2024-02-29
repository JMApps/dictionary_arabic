import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../main/widgets/add_collection_button.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import 'dialogs/add_collection_dialog.dart';
import 'items/collection_item.dart';

class AllCollectionsPage extends StatefulWidget {
  const AllCollectionsPage({super.key});

  @override
  State<AllCollectionsPage> createState() => _AllCollectionsPageState();
}

class _AllCollectionsPageState extends State<AllCollectionsPage> {
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
            builder: (BuildContext context, query, _) {
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    stretch: true,
                    middle: const Text(AppStrings.allCollections),
                    previousPageTitle: AppStrings.main,
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
                  ),
                  FutureBuilder<List<CollectionEntity>>(
                    future: Provider.of<CollectionsState>(context).fetchAllCollections(),
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
                                  return CollectionItem(collectionModel: collectionModel);
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: ErrorDataText(errorText: snapshot.error.toString()),
                        );
                      } else {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const DataText(text: AppStrings.collectionsIfEmpty),
                              const SizedBox(height: 7),
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
