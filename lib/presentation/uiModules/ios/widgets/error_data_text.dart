import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDataText extends StatelessWidget {
  const ErrorDataText({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      errorText,
      style: const TextStyle(
        fontSize: 18,
        color: CupertinoColors.destructiveRed,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
