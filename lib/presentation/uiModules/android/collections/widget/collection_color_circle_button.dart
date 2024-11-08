import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/add_change_collection_state.dart';

class CollectionColorCircleButton extends StatelessWidget {
  const CollectionColorCircleButton({
    super.key,
    required this.buttonIndex,
  });

  final int buttonIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddChangeCollectionState>(
      builder: (BuildContext context, colorState, _) {
        return GestureDetector(
          onTap: () {
            colorState.setColorIndex = buttonIndex;
          },
          child: Icon(
            colorState.getColorIndex == buttonIndex
                ? Icons.check_circle_rounded
                : Icons.circle,
            color: AppStyles.collectionColors[buttonIndex],
            size: 55,
          ),
        );
      },
    );
  }
}
