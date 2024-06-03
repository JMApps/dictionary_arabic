import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/state/search_query_state.dart';
import '../../../../../data/state/search_values_state.dart';
import '../../../../../domain/entities/word_search_entity.dart';

class SearchValueItem extends StatelessWidget {
  const SearchValueItem({
    super.key,
    required this.model,
  });

  final WordSearchEntity model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 6,
      onTap: () {
        Provider.of<SearchQueryState>(context, listen: false).setQuery = model.searchValue;
      },
      title: Text(
        model.searchValue,
        style: const TextStyle(fontSize: 18),
      ),
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.search,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteSearchValueById(
            searchValueId: model.id,
          );
        },
        icon: const Icon(
          Icons.clear,
          size: 17.5,
        ),
      ),
    );
  }
}
