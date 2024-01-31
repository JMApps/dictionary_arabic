import 'package:arabic/core/routes/route_names.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/styles/app_styles.dart';

class MainSearchWordTextField extends StatelessWidget {
  const MainSearchWordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: true,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        color: CupertinoColors.systemGrey5,
      ),
      prefix: const Padding(
        padding: AppStyles.mardingOnlyLeftMini,
        child: Icon(
          CupertinoIcons.search,
          color: CupertinoColors.systemGrey,
        ),
      ),
      placeholder: AppStrings.searchWords,
      placeholderStyle: const TextStyle(
        fontSize: 16,
        color: CupertinoColors.systemGrey,
      ),
      onTap: () {
        Navigator.pushNamed(context, RouteNames.searchWordsPage);
      },
    );
  }
}
