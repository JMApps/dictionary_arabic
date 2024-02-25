import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../data/state/search_values_state.dart';
import 'lists/search_word_list.dart';

class SearchWordsPage extends StatefulWidget {
  const SearchWordsPage({super.key});

  @override
  State<SearchWordsPage> createState() => _SearchWordsPageState();
}

class _SearchWordsPageState extends State<SearchWordsPage> {
  final TextEditingController _wordsController = TextEditingController();

  @override
  void dispose() {
    _wordsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchQueryState>(
          create: (_) => SearchQueryState(),
        ),
        ChangeNotifierProvider<SearchValuesState>(
          create: (_) => SearchValuesState(),
        ),
      ],
      child: Consumer<SearchQueryState>(
        builder: (BuildContext context, query, _) {
          _wordsController.text = query.getQuery;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appColors.inversePrimary,
              titleSpacing: 0,
              title: TextField(
                controller: _wordsController,
                autofocus: true,
                autocorrect: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  contentPadding: AppStyles.mardingOnlyBottomMini,
                  border: InputBorder.none,
                  hintText: AppStrings.searchWords,
                  hintStyle: TextStyle(fontSize: 22),
                ),
                style: const TextStyle(fontSize: 22),
                onChanged: (value) => query.setQuery = value,
                onSubmitted: (value) async {
                  if (value.trim().isNotEmpty) {
                    await Provider.of<SearchValuesState>(context, listen: false).fetchAddSearchValue(
                      searchValue: value.trim().toLowerCase(),
                    );
                  }
                },
              ),
              actions: [
                query.getQuery.isNotEmpty ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (_wordsController.text.isNotEmpty) {
                      _wordsController.clear();
                      query.setQuery = '';
                    }
                  },
                  icon: const Icon(Icons.clear),
                ) : const SizedBox(),
              ],
            ),
            body: const SearchWordList(),
          );
        },
      ),
    );
  }
}
