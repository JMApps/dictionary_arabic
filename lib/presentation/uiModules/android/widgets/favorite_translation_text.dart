import 'package:flutter/material.dart';

class FavoriteTranslationText extends StatelessWidget {
  const FavoriteTranslationText({
    super.key,
    required this.translation,
    required this.index,
    required this.serializableIndex,
  });

  final String translation;
  final int index;
  final int serializableIndex;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    RegExp arabic = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');
    TextStyle translationStyle = TextStyle(
      fontSize: 20,
      color: serializableIndex == -1 ? appColors.onSurface : index == serializableIndex ? appColors.onSurface : Colors.grey,
      fontFamily: 'SF Pro Regular',
      height: 1,
    );
    TextStyle arabicStyle = TextStyle(
      fontSize: 18,
      color: appColors.primary,
      fontFamily: 'Uthmanic',
    );
    List<TextSpan> translationDouble(String text, RegExp regex) {
      List<TextSpan> spans = [];
      var matches = regex.allMatches(text);
      int start = 0;
      for (var match in matches) {
        if (start < match.start) {
          spans.add(
            TextSpan(
              text: text.substring(start, match.start).replaceAll('\\n', '\n'),
              style: translationStyle,
            ),
          );
        }
        spans.add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: arabicStyle,
          ),
        );
        start = match.end;
      }
      if (start < text.length) {
        spans.add(
          TextSpan(
            text: text.substring(start).replaceAll('\\n', '\n'),
            style: translationStyle,
          ),
        );
      }
      return spans;
    }
    return RichText(
      text: TextSpan(
        children: translationDouble(translation, arabic),
      ),
    );
  }
}
