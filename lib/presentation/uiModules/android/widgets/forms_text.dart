import 'package:flutter/material.dart';

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
          for (var form in ['мн.', 'дв.', 'ж.', 'м.', 'стр.', 'см.', '='])
            if (content.contains(form))
              TextSpan(
                text: '$form ',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontFamily: 'SF Pro Regular',
                ),
              ),
          TextSpan(
            text: content.replaceAll(RegExp('мн.|дв.|ж.|м.|стр.|см.ّ|=|ّّّ'), ''),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontFamily: 'Uthmanic',
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
