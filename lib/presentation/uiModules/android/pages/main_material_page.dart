import 'package:arabic/core/strings/app_strings.dart';
import 'package:flutter/material.dart';

class MainMaterialPage extends StatelessWidget {
  const MainMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appName,
        ),
      ),
      body: Container(),
    );
  }
}
