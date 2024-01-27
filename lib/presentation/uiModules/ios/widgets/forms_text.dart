import 'package:flutter/cupertino.dart';

class FormsText extends StatelessWidget {
  const FormsText({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for (var form in ['мн.', 'дв.', 'ж.', 'м'])
            if (content.contains(form))
              TextSpan(
                text: '$form ',
                style: const TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemGrey2,
                  fontFamily: 'Arial',
                ),
              ),
          TextSpan(
            text: content.replaceAll(RegExp('мн\.|дв\.|ж\.|м\.'), ''),
            style: const TextStyle(
              fontSize: 22,
              color: CupertinoColors.systemGrey,
              fontFamily: 'Uthmanic',
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
