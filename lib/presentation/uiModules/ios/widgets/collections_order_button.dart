import 'package:flutter/cupertino.dart';

class CollectionsOrderButton extends StatelessWidget {
  const CollectionsOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        // Добавить методы сортировки
      },
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.sort_up),
    );
  }
}
