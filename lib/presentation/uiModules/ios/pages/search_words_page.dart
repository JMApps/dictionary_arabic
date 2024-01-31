import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../data/state/search_query_state.dart';
import '../../../../data/state/search_values_state.dart';
import '../../../../data/state/word_exact_match_state.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../items/search_word_item.dart';
import '../lists/search_values_list.dart';
import '../widgets/data_text.dart';
import '../widgets/error_data_text.dart';

class SearchWordsPage extends StatefulWidget {
  const SearchWordsPage({super.key});

  @override
  State<SearchWordsPage> createState() => _SearchWordsPageState();
}

class _SearchWordsPageState extends State<SearchWordsPage> {
  final TextEditingController _wordsController = TextEditingController();
  final DefaultDictionaryUseCase _dictionaryUseCase = DefaultDictionaryUseCase(DefaultDictionaryDataRepository());

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
            child: SafeArea(
              bottom: false,
              child: FutureBuilder<List<DictionaryEntity>>(
                future: _dictionaryUseCase.fetchSearchWords(
                  searchQuery: query.getQuery.toLowerCase(),
                  exactMatch: Provider.of<WordExactMatchState>(context, listen: false).getExactMatch,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty && query.getQuery.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: AppStyles.mainMardingMini,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: AppStrings.matchesFound,
                                  style: TextStyle(
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: '${snapshot.data!.length}',
                                  style: const TextStyle(
                                    color: CupertinoColors.systemBlue,
                                  ),
                                ),
                              ],
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CupertinoScrollbar(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DictionaryEntity model = snapshot.data![index];
                                return SearchWordItem(model: model, index: index);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasData && query.getQuery.isNotEmpty) {
                    return const DataText(text: AppStrings.queryIsEmpty);
                  } else if (snapshot.hasError) {
                    return ErrorDataText(errorText: snapshot.error.toString());
                  } else {
                    return const SearchValuesList();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
