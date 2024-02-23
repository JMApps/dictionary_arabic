import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
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
      visualDensity: VisualDensity.compact,
      contentPadding: AppStyles.mardingSymmetricHorMini,
      onTap: () {
        Provider.of<SearchQueryState>(context, listen: false).setQuery = model.searchValue;
      },
      title: Text(
        model.searchValue,
        style: const TextStyle(
          fontSize: 20,
        ),
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
