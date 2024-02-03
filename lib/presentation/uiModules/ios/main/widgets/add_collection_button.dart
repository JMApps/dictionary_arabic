import 'package:flutter/cupertino.dart';

import '../../collections/dialogs/add_collection_dialog.dart';

class AddCollectionButton extends StatelessWidget {
  const AddCollectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(
        CupertinoIcons.add_circled_solid,
        size: 32.5,
      ),
      onPressed: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const AddCollectionDialog();
          },
        );
      },
    );
  }
}
