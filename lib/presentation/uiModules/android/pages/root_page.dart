import 'package:arabic/core/strings/app_strings.dart';
import 'package:arabic/presentation/uiModules/android/pages/main_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: MainPage(),
    );
  }
}
