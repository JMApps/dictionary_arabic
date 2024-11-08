import 'package:flutter/material.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import 'search_collection_future.dart';

class SearchCollectionDelegate extends SearchDelegate {
  SearchCollectionDelegate() : super(searchFieldLabel: AppStrings.searchCollections);

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
        padding: AppStyles.mardingOnlyLeft,
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchCollectionFuture(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchCollectionFuture(query: query);
  }
}
