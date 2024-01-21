import 'package:flutter/cupertino.dart';

import '../../../../core/styles/app_styles.dart';

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
    return Container(
      padding: AppStyles.mainMarding,
      decoration: const BoxDecoration(
        borderRadius: AppStyles.mainBorderMini,
        color: CupertinoColors.systemFill,
      ),
      child: CupertinoButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        alignment: Alignment.centerLeft,
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
                color: CupertinoColors.systemGrey,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
