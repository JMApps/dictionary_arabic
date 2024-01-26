import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class ShareWordButton extends StatelessWidget {
  const ShareWordButton({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Share.share(
          content,
          sharePositionOrigin: const Rect.fromLTWH(1, 1, 1, 2 / 2),
        );
      },
      child: const Icon(CupertinoIcons.share),
    );
  }
}
