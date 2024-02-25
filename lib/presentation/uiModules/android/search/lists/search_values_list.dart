import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/strings/app_strings.dart';
import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/search_values_state.dart';
import '../../../../../domain/entities/word_search_entity.dart';
import '../items/search_value_item.dart';

class SearchValuesList extends StatelessWidget {
  const SearchValuesList({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return FutureBuilder<List<WordSearchEntity>>(
      future: Provider.of<SearchValuesState>(context).fetchAllSearchValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            children: [
              snapshot.data!.length > 5
                  ? ListTile(
                      tileColor: appColors.inversePrimary.withOpacity(0.75),
                      contentPadding: AppStyles.mardingSymmetricHor,
                      visualDensity: const VisualDensity(vertical: -4),
                      onTap: () async {
                        await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteAllSearchValues();
                      },
                      title: const Text(
                        AppStrings.recent,
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                        ),
                      ),
                      trailing: const Text(
                        AppStrings.clear,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final WordSearchEntity model = snapshot.data![index];
                      return SearchValueItem(model: model);
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text(
              AppStrings.startSearch,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'SF Pro',
              ),
            ),
          );
        }
      },
    );
  }
}
