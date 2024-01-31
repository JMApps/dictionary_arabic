import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/search_values_state.dart';
import '../../../../domain/entities/word_search_entity.dart';
import '../items/search_value_item.dart';

class SearchValuesList extends StatefulWidget {
  const SearchValuesList({super.key});

  @override
  State<SearchValuesList> createState() => _SearchValuesListState();
}

class _SearchValuesListState extends State<SearchValuesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WordSearchEntity>>(
      future: Provider.of<SearchValuesState>(context).fetchAllSearchValues(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return CupertinoScrollbar(
            child: Column(
              children: [
                snapshot.data!.length > 3 ? CupertinoListTile(
                  onTap: () async {
                    await Provider.of<SearchValuesState>(context, listen: false).fetchDeleteAllSearchValues();
                  },
                  title: const Text(
                    AppStrings.clearList,
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  trailing: const Icon(
                    CupertinoIcons.clear,
                    color: CupertinoColors.systemGrey,
                  ),
                  padding: AppStyles.horizontalVerticalMini,
                ) : const SizedBox(),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final WordSearchEntity model = snapshot.data![index];
                      return SearchValueItem(model: model, index: index);
                    },
                  ),
                ),
              ],
            ),
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
