import 'package:flutter/cupertino.dart';

import '../pages/add_favorite_word_page.dart';

class AddFavoriteWordButton extends StatelessWidget {
  const AddFavoriteWordButton({
    super.key,
    required this.nr,
  });

  final int nr;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => AddFavoriteWordPage(nr: nr),
        );
      },
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.bookmark),
    );
  }
}
