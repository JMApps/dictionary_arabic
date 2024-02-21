import 'package:flutter/material.dart';

import '../../../../../core/styles/app_styles.dart';

class MainCardItem extends StatelessWidget {
  const MainCardItem({
    super.key,
    required this.routeName,
    required this.iconName,
    required this.title,
    required this.color,
  });

  final String routeName;
  final IconData iconName;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    return Card(
      color: appColors.inversePrimary.withOpacity(0.15),
      elevation: 0,
      margin: AppStyles.mardingSymmetricHorMini,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        borderRadius: AppStyles.mainBorderMini,
        child: Container(
          padding: AppStyles.mainMarding,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: AppStyles.mainBorderMini,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconName,
                color: color,
                size: 30,
              ),
              const SizedBox(height: 7),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'SF Pro',
                  letterSpacing: 0.25,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
