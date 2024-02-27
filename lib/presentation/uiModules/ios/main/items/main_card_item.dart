import 'package:flutter/cupertino.dart';

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
    return CupertinoListSection.insetGrouped(
      margin: AppStyles.mardingSymmetricHorMini,
      children: [
        Container(
          padding: AppStyles.mainMarding,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: AppStyles.mainBorderMini,
          ),
          child: CupertinoButton(
            onPressed: () => Navigator.pushNamed(context, routeName),
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.zero,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  iconName,
                  color: color,
                  size: 32.5,
                ),
                const SizedBox(height: 7),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
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
      ],
    );
  }
}
