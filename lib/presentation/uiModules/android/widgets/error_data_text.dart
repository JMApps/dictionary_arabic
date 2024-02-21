import 'package:flutter/material.dart';

import '../../../../core/styles/app_styles.dart';

class ErrorDataText extends StatelessWidget {
  const ErrorDataText({
    super.key,
    required this.errorText,
  });

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppStyles.mainMarding,
        child: SelectableText(
          errorText,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
