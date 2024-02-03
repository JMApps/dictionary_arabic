import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../data/state/search_values_state.dart';
import 'lists/word_search_list.dart';

class SearchWordsPage extends StatefulWidget {
  const SearchWordsPage({super.key});

  @override
  State<SearchWordsPage> createState() => _SearchWordsPageState();
}

class _SearchWordsPageState extends State<SearchWordsPage> {
  final TextEditingController _wordsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchQueryState(),
        ),
      ],
      child: Consumer<SearchQueryState>(
        builder: (BuildContext context, SearchQueryState query, _) {
          _wordsController.text = query.getQuery;
          return CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: CupertinoNavigationBar(
              middle: CupertinoSearchTextField(
                controller: _wordsController,
                placeholder: AppStrings.searchWords,
                autofocus: true,
                autocorrect: false,
                onChanged: (value) {
                  query.setQuery = value;
                },
                onSubmitted: (value) async {
                  if (value.trim().isNotEmpty) {
                    await Provider.of<SearchValuesState>(context, listen: false).fetchAddSearchValue(
                      searchValue: value.toLowerCase().trim(),
                    );
                  }
                },
              ),
              leading: const SizedBox(),
              trailing: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: AppStyles.mardingOnlyLeftMini,
                child: const Text(AppStrings.cancel),
              ),
            ),
            child: const SafeArea(
              bottom: false,
              child: WordSearchList(),
            ),
          );
        },
      ),
    );
  }
}
