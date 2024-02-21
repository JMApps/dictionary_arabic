import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/state/collections_state.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../domain/entities/collection_entity.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';
import 'dialogs/add_collection_dialog.dart';
import 'items/collection_item.dart';
import 'widget/search_collection_delegate.dart';

class AllCollectionsPage extends StatefulWidget {
  const AllCollectionsPage({super.key});

  @override
  State<AllCollectionsPage> createState() => _AllCollectionsPageState();
}

class _AllCollectionsPageState extends State<AllCollectionsPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _collectionsController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    _collectionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
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
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: appColors.inversePrimary,
                stretch: true,
                forceElevated: true,
                centerTitle: true,
                title: const Text(AppStrings.allCollections),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchCollectionDelegate(),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              FutureBuilder<List<CollectionEntity>>(
                future: Provider.of<CollectionsState>(context).fetchAllCollections(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SliverList.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final CollectionEntity collectionModel = snapshot.data![index];
                        return CollectionItem(
                          collectionModel: collectionModel,
                          index: index,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: ErrorDataText(errorText: snapshot.error.toString()),
                    );
                  } else {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: DataText(text: AppStrings.collectionsIfEmpty),
                    );
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddCollectionDialog();
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
