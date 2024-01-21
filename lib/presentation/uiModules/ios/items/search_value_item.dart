import 'package:arabic/data/state/search_values_state.dart';
import 'package:arabic/data/state/words_search_state.dart';
import 'package:arabic/domain/entities/word_search_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
      onTap: () {
        Provider.of<WordsSearchState>(context, listen: false).setQuery = model.searchValue;
      },
      title: Text(model.searchValue),
      leading: const Icon(CupertinoIcons.time),
      trailing: CupertinoButton(
        onPressed: () async {
          await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteSearchValueById(
            searchValueId: model.id,
          );
        },
        child: const Icon(CupertinoIcons.delete_left, size: 17.5),
      ),
    );
  }
}
