import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_styles.dart';
import '../../../../../data/state/favorite_words_state.dart';
import '../../../../../domain/entities/favorite_dictionary_entity.dart';
import '../../widgets/forms_text.dart';
import '../../widgets/translation_text.dart';

class FavoriteDetailWordItem extends StatelessWidget {
  const FavoriteDetailWordItem({
    super.key,
    required this.favoriteWordModel,
  });

  final FavoriteDictionaryEntity favoriteWordModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Container(
      margin: AppStyles.mardingWithoutTopMini,
      child: InkWell(
        borderRadius: AppStyles.mainBorderMini,
        child: Container(
          padding: AppStyles.wordCardMarding,
          decoration: BoxDecoration(
            color: appColors.primary.withOpacity(0.05),
            borderRadius: AppStyles.mainBorderMini,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          favoriteWordModel.arabicWord,
                          style: const TextStyle(
                            fontSize: 50,
                            fontFamily: 'Uthmanic',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(width: 8),
                        favoriteWordModel.forms != null
                            ? FormsText(content: favoriteWordModel.forms!)
                            : const SizedBox(),
                        const SizedBox(width: 8),
                        favoriteWordModel.additional != null
                            ? FormsText(content: favoriteWordModel.additional!)
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TranslationText(
                      translation: favoriteWordModel.translation,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      favoriteWordModel.homonymNr != null
                          ? Text(
                        favoriteWordModel.homonymNr.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: appColors.onSurface,
                        ),
                      ) : const SizedBox(),
                      const SizedBox(width: 4),
                      favoriteWordModel.vocalization != null
                          ? Text(
                        favoriteWordModel.vocalization!,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      )
                          : const SizedBox(),
                      const SizedBox(width: 4),
                      favoriteWordModel.form != null
                          ? Text(
                        favoriteWordModel.form!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Heuristica',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ) : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    favoriteWordModel.root,
                    style: TextStyle(
                      fontSize: 30,
                      color: appColors.error,
                      fontFamily: 'Uthmanic',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () async {
                      Navigator.pop(context);
                      await Provider.of<FavoriteWordsState>(context, listen: false).deleteFavoriteWord(
                        favoriteWordId: favoriteWordModel.wordNumber,
                      );
                    },
                    icon: Icon(
                      Icons.bookmark,
                      size: 30,
                      color: appColors.primary,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      // Поменять отображение
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: appColors.tertiary,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      // Переместить
                    },
                    icon: Icon(
                      Icons.drive_file_move_rounded,
                      color: appColors.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
