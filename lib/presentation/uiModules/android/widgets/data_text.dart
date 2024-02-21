import 'package:flutter/material.dart';

import '../../../../core/styles/app_styles.dart';

class DataText extends StatelessWidget {
  const DataText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppStyles.mainMarding,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
