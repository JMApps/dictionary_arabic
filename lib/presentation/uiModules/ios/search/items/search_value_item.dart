import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/search_values_state.dart';
import '../../../../../data/state/search_query_state.dart';
import '../../../../../domain/entities/word_search_entity.dart';

class SearchValueItem extends StatelessWidget {
  const SearchValueItem({
    super.key,
    required this.model,
    required this.index,
  });

  final WordSearchEntity model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      padding: AppStyles.mardingSymmetricHor,
      onTap: () {
        Provider.of<SearchQueryState>(context, listen: false).setQuery = model.searchValue;
      },
      title: Text(model.searchValue),
      leading: const Icon(
        CupertinoIcons.time,
        color: CupertinoColors.systemBlue,
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteSearchValueById(
            searchValueId: model.id,
          );
        },
        child: const Icon(
          CupertinoIcons.delete_left,
          color: CupertinoColors.systemBlue,
          size: 17.5,
        ),
      ),
    );
  }
}
