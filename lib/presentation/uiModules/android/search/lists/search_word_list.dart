import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/default_dictionary_state.dart';
import '../../../../../data/state/search_query_state.dart';
import '../../../../../data/state/word_exact_match_state.dart';
import '../../../../../domain/entities/dictionary_entity.dart';
import '../../widgets/data_text.dart';
import '../../widgets/error_data_text.dart';
import '../../widgets/word_item.dart';
import 'search_values_list.dart';

class SearchWordList extends StatelessWidget {
  const SearchWordList({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final String query = Provider.of<SearchQueryState>(context).getQuery;
    return FutureBuilder<List<DictionaryEntity>>(
      future: Provider.of<DefaultDictionaryState>(context, listen: false).searchWords(
        searchQuery: query.trim().toLowerCase(),
        exactMatch: Provider.of<WordExactMatchState>(context, listen: false).getExactMatch,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty && query.isNotEmpty) {
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
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: '${snapshot.data!.length}',
                        style: TextStyle(
                          color: appColors.primary,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DictionaryEntity model =
                      snapshot.data![index];
                      return WordItem(model: model);
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasData && query.isNotEmpty) {
          return const DataText(text: AppStrings.queryIsEmpty);
        } else if (snapshot.hasError) {
          return ErrorDataText(errorText: snapshot.error.toString());
        } else {
          return const SearchValuesList();
        }
      },
    );
  }
}
