import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import 'search_words_page.dart';

class FavoriteWordsIsEmptyPage extends StatelessWidget {
  const FavoriteWordsIsEmptyPage({
    super.key,
    required this.collectionTitle,
  });

  final String collectionTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(collectionTitle),
        previousPageTitle: AppStrings.toBack,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.add_circled),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => const SearchWordsPage(),
            );
          },
        ),
      ),
      child: const Center(
        child: Padding(
          padding: AppStyles.mainMarding,
          child: Text(
            AppStrings.favoriteWordsIfEmpty,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
