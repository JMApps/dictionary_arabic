import 'package:flutter/cupertino.dart';

import '../../../../../../core/styles/app_styles.dart';
import '../../../../../../domain/entities/favorite_dictionary_entity.dart';

class CardSwipeItem extends StatelessWidget {
  const CardSwipeItem({super.key, required this.favoriteWordModel});

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? CupertinoColors.darkBackgroundGray : CupertinoColors.white,
          borderRadius: AppStyles.mainBorder,
          boxShadow: const [
            BoxShadow(spreadRadius: 0.25, blurRadius: 1),
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
    );
  }
}
