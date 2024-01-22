import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collection_search_state.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../dialogs/add_collection_dialog.dart';
import '../items/collection_item.dart';
import '../widgets/error_data_text.dart';
import 'collection_is_empty_page.dart';

class AllCollectionsPage extends StatefulWidget {
  const AllCollectionsPage({super.key});

  @override
  State<AllCollectionsPage> createState() => _AllCollectionsPageState();
}

class _AllCollectionsPageState extends State<AllCollectionsPage> {
  final TextEditingController _collectionsController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _recentCollections = [];

  @override
  Widget build(BuildContext context) {
    final CollectionsState collectionsState = Provider.of<CollectionsState>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CollectionSearchState(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (!focusNode.hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          child: Consumer<CollectionSearchState>(
            builder: (BuildContext context, CollectionSearchState query, _) {
              return FutureBuilder<List<CollectionEntity>>(
                future: collectionsState.fetchAllCollections(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    _collections = snapshot.data!;
                    _recentCollections = query.getQuery.isEmpty
                        ? _collections
                        : _collections.where((element) => element.title.toLowerCase().contains(query.getQuery.toLowerCase())).toList();
                    return CustomScrollView(
                      slivers: [
                        CupertinoSliverNavigationBar(
                          stretch: true,
                          middle: const Text(AppStrings.allCollections),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Text(
                              AppStrings.add,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return const AddCollectionDialog();
                                },
                              );
                            },
                          ),
                          previousPageTitle: AppStrings.main,
                          largeTitle: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: CupertinoSearchTextField(
                              onChanged: (value) {
                                query.setQuery = value;
                              },
                              controller: _collectionsController,
                              placeholder: AppStrings.searchCollections,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CupertinoListSection.insetGrouped(
                            margin: AppStyles.mardingWithoutBottomMini,
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _recentCollections.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final CollectionEntity model = _recentCollections[index];
                                  return CollectionItem(
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
                    return const CollectionIsEmptyPage();
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
