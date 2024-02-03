import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';
import 'dialogs/add_collection_dialog.dart';

class CollectionIsEmptyPage extends StatelessWidget {
  const CollectionIsEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(AppStrings.allCollections),
        previousPageTitle: AppStrings.main,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(AppStrings.add),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return const AddCollectionDialog();
              },
            );
          },
        ),
      ),
      child: const Center(
        child: Padding(
          padding: AppStyles.mainMarding,
          child: Text(
            AppStrings.collectionsIfEmpty,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
