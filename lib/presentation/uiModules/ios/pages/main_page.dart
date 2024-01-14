import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          AppStrings.appName,
        ),
      ),
      child: Container(),
    );
  }
}
