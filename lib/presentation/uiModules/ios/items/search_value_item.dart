import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../data/state/search_values_state.dart';
import '../../../../data/state/words_search_state.dart';
import '../../../../domain/entities/word_search_entity.dart';

class SearchValueItem extends StatefulWidget {
  const SearchValueItem({
    super.key,
    required this.model,
    required this.index,
  });

  final WordSearchEntity model;
  final int index;

  @override
  State<SearchValueItem> createState() => _SearchValueItemState();
}

class _SearchValueItemState extends State<SearchValueItem> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      onTap: () {
        Provider.of<WordsSearchState>(context, listen: false).setQuery = widget.model.searchValue;
        if (!_focusNode.hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      title: Text(widget.model.searchValue),
      leading: const Icon(CupertinoIcons.time),
      trailing: CupertinoButton(
        onPressed: () async {
          await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteSearchValueById(
            searchValueId: widget.model.id,
          );
        },
        child: const Icon(CupertinoIcons.delete_left, size: 17.5),
      ),
    );
  }
}
