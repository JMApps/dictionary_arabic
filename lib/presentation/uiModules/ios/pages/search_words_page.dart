import 'package:arabic/data/repositories/default_dictionary_data_repository.dart';
import 'package:arabic/data/state/words_search_state.dart';
import 'package:arabic/domain/entities/dictionary_entity.dart';
import 'package:arabic/domain/usecases/default_dictionary_use_case.dart';
import 'package:arabic/presentation/uiModules/ios/items/word_item.dart';
import 'package:arabic/presentation/uiModules/ios/widgets/error_data_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';

class SearchWordsPage extends StatefulWidget {
  const SearchWordsPage({super.key});

  @override
  State<SearchWordsPage> createState() => _SearchWordsPageState();
}

class _SearchWordsPageState extends State<SearchWordsPage> {
  final TextEditingController _wordsController = TextEditingController();
  final DefaultDictionaryUseCase _dictionaryUseCase =
      DefaultDictionaryUseCase(DefaultDictionaryDataRepository());
  List<DictionaryEntity> _words = [];
  List<DictionaryEntity> _recentWords = [];

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
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: CupertinoSearchTextField(
                // не забыть закрывать клавиатуру
                onChanged: (value) {
                  query.setQuery = value;
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
              future: _dictionaryUseCase.fetchAllWords(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _words = snapshot.data!;
                  _recentWords = query.getQuery.isEmpty
                      ? _words
                      : _words.where((element) {
                          return (element.arabicWordWH
                                  .contains(query.getQuery.toLowerCase()) ||
                              (element.shortMeaning?.contains(
                                      query.getQuery.toLowerCase()) ??
                                  false));
                        }).toList();
                  return Column(
                    children: [
                      const Text(
                        'This is a my short text',
                        style: TextStyle(),
                      ),
                      Expanded(
                        child: CupertinoScrollbar(
                          child: ListView.builder(
                            itemCount: _recentWords.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DictionaryEntity model = _recentWords[index];
                              return WordItem(
                                model: model,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return ErrorDataText(errorText: snapshot.error.toString());
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
