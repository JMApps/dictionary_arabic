import 'package:flutter/cupertino.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../domain/entities/dictionary_entity.dart';

class WordDetailItem extends StatefulWidget {
  const WordDetailItem({
    super.key,
    required this.model,
  });

  final DictionaryEntity model;

  @override
  State<WordDetailItem> createState() => _WordDetailItemState();
}

class _WordDetailItemState extends State<WordDetailItem> {
  @override
  Widget build(BuildContext context) {
    RegExp arabic = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');
    TextStyle defaultStyle = TextStyle(
      fontSize: 18,
      color: CupertinoColors.label.resolveFrom(context),
      fontFamily: 'Arial',
      height: 1.5,
    );

    TextStyle arabicStyle = const TextStyle(
      fontSize: 18,
      color: CupertinoColors.systemBlue,
      fontFamily: 'Uthmanic',
      height: 1.5,
    );
    List<TextSpan> getSpans(String text, RegExp regex) {
      List<TextSpan> spans = [];

      var matches = regex.allMatches(text);
      int start = 0;

      for (var match in matches) {
        if (start < match.start) {
          spans.add(
            TextSpan(
              text: text.substring(start, match.start).replaceAll('\\n', '\n'),
              style: defaultStyle,
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
            style: defaultStyle,
          ),
        );
      }

      return spans;
    }

    return Padding(
      padding: AppStyles.mainMarding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoListTile(
            padding: EdgeInsets.zero,
            title: Row(
              children: [
                Text(
                  widget.model.arabicWord,
                  style: const TextStyle(
                    fontSize: 50,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(width: 14),
                widget.model.forms != null
                    ? Text.rich(
                        TextSpan(
                          children: [
                            if (widget.model.forms!.contains('мн.'))
                              const TextSpan(
                                text: 'мн.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CupertinoColors.systemGrey2,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            TextSpan(
                              text: widget.model.forms!.replaceAll('мн.', ''),
                              style: const TextStyle(
                                fontSize: 25,
                                color: CupertinoColors.systemGrey,
                                fontFamily: 'Uthmanic',
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                      )
                    : const SizedBox(),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.model.vocalization != null
                        ? Text(
                            widget.model.vocalization!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: CupertinoColors.systemGrey,
                              fontFamily: 'Arial',
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 7),
                    widget.model.form != null
                        ? Text(
                            widget.model.form!,
                            style: const TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 20,
                              letterSpacing: 0.5,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  widget.model.root,
                  style: const TextStyle(
                    fontSize: 25,
                    color: CupertinoColors.systemRed,
                    fontFamily: 'Uthmanic',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: getSpans(widget.model.translation, arabic),
            ),
          ),
        ],
      ),
    );
  }
}
