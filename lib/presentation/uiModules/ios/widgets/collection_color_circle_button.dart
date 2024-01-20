import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../data/state/collections_state.dart';

class CollectionColorCircleButton extends StatelessWidget {
  const CollectionColorCircleButton({
    super.key,
    required this.buttonIndex,
  });

  final int buttonIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CollectionsState>(context, listen: false).setColorIndex = buttonIndex;
      },
      child: Icon(
        context.watch<CollectionsState>().getColorIndex == buttonIndex
            ? CupertinoIcons.checkmark_circle_fill
            : CupertinoIcons.circle_fill,
        color: AppStyles.collectionColors[buttonIndex],
        size: 50,
      ),
    );
  }
}
