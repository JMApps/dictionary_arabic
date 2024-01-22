import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../data/repositories/default_dictionary_data_repository.dart';
import '../../../../data/state/search_values_state.dart';
import '../../../../data/state/words_search_state.dart';
import '../../../../domain/entities/dictionary_entity.dart';
import '../../../../domain/usecases/default_dictionary_use_case.dart';
import '../items/word_item.dart';
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
          create: (_) => WordsSearchState(),
        ),
      ],
      child: Consumer<WordsSearchState>(
        builder: (BuildContext context, WordsSearchState query, _) {
          _wordsController.text = query.getQuery;
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: CupertinoSearchTextField(
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
                controller: _wordsController,
                placeholder: AppStrings.searchWords,
              ),
              leading: const SizedBox(),
              trailing: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.zero,
                child: const Text(AppStrings.cancel),
              ),
            ),
            child: FutureBuilder<List<DictionaryEntity>>(
              future: _dictionaryUseCase.fetchSearchWords(searchQuery: query.getQuery),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty && query.getQuery.isNotEmpty) {
                  return CupertinoScrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DictionaryEntity model = snapshot.data![index];
                        return WordItem(
                          model: model,
                          index: index,
                        );
                      },
                    ),
                  );
                } else if (snapshot.data!.isEmpty && query.getQuery.isNotEmpty) {
                  return const DataText(text: AppStrings.queryIsEmpty);
                } else if (snapshot.hasError) {
                  return ErrorDataText(errorText: snapshot.error.toString());
                } else {
                  return const SearchValuesList();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
