import 'package:flutter/cupertino.dart';

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
        child: Text(
          errorText,
          style: const TextStyle(
            fontSize: 18,
            color: CupertinoColors.destructiveRed,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
