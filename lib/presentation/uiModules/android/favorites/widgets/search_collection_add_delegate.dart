import 'package:flutter/material.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import 'search_collection_add_future.dart';

class SearchCollectionAddDelegate extends SearchDelegate {
  SearchCollectionAddDelegate({
    required this.wordModel,
    required this.serializableIndex,
  }) : super(searchFieldLabel: AppStrings.searchCollections);

  final DictionaryEntity wordModel;
  final int serializableIndex;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: theme.colorScheme.inversePrimary,
        titleSpacing: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              onPressed: () {
                query = '';
              },
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: transitionAnimation,
              ),
            ) : const SizedBox(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Padding(
        padding: AppStyles.mardingOnlyLeftMini,
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchCollectionAddFuture(
      query: query,
      wordModel: wordModel,
      serializableIndex: serializableIndex,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchCollectionAddFuture(
      query: query,
      wordModel: wordModel,
      serializableIndex: serializableIndex,
    );
  }
}
