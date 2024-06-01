import 'package:flutter/material.dart';

import '../../../../../../../core/styles/app_styles.dart';
import '../../../../../../../domain/entities/favorite_dictionary_entity.dart';

class CardSwipeItem extends StatelessWidget {
  const CardSwipeItem({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors.secondaryContainer,
            borderRadius: AppStyles.mainBorder,
            boxShadow: const [
              BoxShadow(spreadRadius: 0.1, blurRadius: 0.5),
            ],
          ),
          child: Text(
            favoriteWordModel.arabicWord,
            style: const TextStyle(
              fontSize: 35,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Uthmanic',
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
