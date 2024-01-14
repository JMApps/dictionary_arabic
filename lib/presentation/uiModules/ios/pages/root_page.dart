import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/presentation/uiModules/ios/pages/main_page.dart';
import 'package:flutter/cupertino.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: MainPage(),
    );
  }
}
